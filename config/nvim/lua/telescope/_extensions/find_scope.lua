local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local previewer_utils = require("telescope.previewers.utils")
local sorters = require("telescope.sorters")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}
local replacement_preview_namespace = vim.api.nvim_create_namespace("telescope_replace_in_scope_preview")

local function get_selected_paths(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selections = picker:get_multi_selection()

    -- When nothing was marked with <Tab>, use the highlighted item.
    if #selections == 0 then
        local selected = action_state.get_selected_entry()

        if selected then
            selections = { selected }
        end
    end

    local paths = {}

    for _, entry in ipairs(selections) do
        if entry.path then
            table.insert(paths, entry.path)
        end
    end

    return paths
end

local function live_grep_selected(prompt_bufnr)
    local paths = get_selected_paths(prompt_bufnr)

    if #paths == 0 then
        vim.notify("No files or directories selected", vim.log.levels.WARN)
        return
    end

    actions.close(prompt_bufnr)

    -- Schedule it after the current Telescope picker has closed.
    vim.schedule(function()
        require("telescope.builtin").live_grep({
            search_dirs = paths,
            prompt_title = "Live Grep in Selected Scope",
        })
    end)
end

local function replace_selected(prompt_bufnr)
    local paths = get_selected_paths(prompt_bufnr)

    if #paths == 0 then
        vim.notify("No files or directories selected", vim.log.levels.WARN)
        return
    end

    local picker = action_state.get_current_picker(prompt_bufnr)
    local cwd = picker.cwd or vim.uv.cwd()

    actions.close(prompt_bufnr)

    vim.schedule(function()
        M.replace_in_scope({ cwd = cwd, search_dirs = paths })
    end)
end

local function parse_replace_prompt(prompt)
    local escaped = false

    for index = 1, #prompt do
        local char = prompt:sub(index, index)

        if char == "/" and not escaped then
            local function unescape(value)
                return value:gsub("\\([\\/])", "%1")
            end

            return unescape(prompt:sub(1, index - 1)), unescape(prompt:sub(index + 1))
        end

        escaped = char == "\\" and not escaped
    end
end

local function replacement_entry_maker(cwd, replacement_state)
    local cwd_prefix = cwd .. "/"

    return function(filename)
        if replacement_state.old == "" then
            return nil
        end

        local path = vim.fs.normalize(filename)

        if not vim.startswith(path, "/") then
            path = vim.fs.normalize(cwd_prefix .. path)
        end

        local lines = replacement_state.lines[path]

        if not lines then
            local ok
            ok, lines = pcall(vim.fn.readfile, path)

            if not ok then
                return nil
            end

            replacement_state.lines[path] = lines
        end

        local relative_path = vim.fs.relpath(cwd, path) or path
        local matches = {}

        for lnum, text in ipairs(lines) do
            local start = 1

            while true do
                local match_start, match_end = text:find(replacement_state.old, start, true)

                if not match_start then
                    break
                end

                table.insert(matches, { lnum = lnum, col = match_start })
                start = match_end + 1
            end
        end

        return {
            value = path,
            ordinal = relative_path,
            display = relative_path,
            filename = path,
            path = path,
            relative_path = relative_path,
            matches = matches,
            old = replacement_state.old,
            replacement = replacement_state.replacement,
        }
    end
end

local function apply_replacements(prompt_bufnr, entries)
    local picker = action_state.get_current_picker(prompt_bufnr)

    if #entries == 0 then
        vim.notify("No matches selected", vim.log.levels.WARN)
        return
    end

    local target_winid = picker.original_win_id
    local entries_by_path = {}

    for _, entry in ipairs(entries) do
        entries_by_path[entry.path] = entry
    end

    actions.close(prompt_bufnr)

    vim.schedule(function()
        local changed_matches = 0
        local changed_files = 0
        local skipped_files = 0
        local first_change

        for path, entry in pairs(entries_by_path) do
            local bufnr = vim.fn.bufadd(path)
            vim.fn.bufload(bufnr)

            if vim.bo[bufnr].modifiable then
                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                local match_count = 0
                local first_match

                for lnum, line in ipairs(lines) do
                    local start = 1

                    while true do
                        local match_start, match_end = line:find(entry.old, start, true)

                        if not match_start then
                            break
                        end

                        first_match = first_match or { lnum = lnum, col = match_start }
                        match_count = match_count + 1
                        start = match_end + 1
                    end
                end

                if match_count > 0 then
                    local search = vim.fn.escape(entry.old, "\\/")
                    local replacement = vim.fn.escape(entry.replacement, "\\/&~")
                    local ok, error_message = pcall(vim.api.nvim_buf_call, bufnr, function()
                        vim.cmd("silent keepjumps keeppatterns %s/\\C\\V" .. search .. "/" .. replacement .. "/g")
                        vim.cmd("silent write")
                    end)

                    if ok then
                        changed_matches = changed_matches + match_count
                        changed_files = changed_files + 1
                        first_change = first_change or { bufnr = bufnr, lnum = first_match.lnum, col = first_match.col }
                    else
                        skipped_files = skipped_files + 1
                        vim.notify(
                            string.format("Failed to replace and save %s: %s", path, error_message),
                            vim.log.levels.ERROR
                        )
                    end
                else
                    skipped_files = skipped_files + 1
                end
            else
                skipped_files = skipped_files + 1
            end
        end

        if first_change and vim.api.nvim_win_is_valid(target_winid) then
            vim.api.nvim_win_set_buf(target_winid, first_change.bufnr)
            vim.api.nvim_win_set_cursor(target_winid, { first_change.lnum, first_change.col - 1 })
        end

        local message = string.format(
            "Replaced %d match%s in %d file%s and saved changes",
            changed_matches,
            changed_matches == 1 and "" or "es",
            changed_files,
            changed_files == 1 and "" or "s"
        )

        if skipped_files > 0 then
            message = message
                .. string.format(
                    "; skipped %d changed, read-only, or failed file%s",
                    skipped_files,
                    skipped_files == 1 and "" or "s"
                )
        end

        vim.notify(message)
    end)
end

local function apply_selected_replacements(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local entries = picker:get_multi_selection()

    if #entries == 0 then
        local selected = action_state.get_selected_entry()

        if selected then
            entries = { selected }
        end
    end

    apply_replacements(prompt_bufnr, entries)
end

local function apply_all_replacements(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local entries = {}

    for entry in picker.manager:iter() do
        table.insert(entries, entry)
    end

    apply_replacements(prompt_bufnr, entries)
end

local function replacement_previewer()
    return previewers.new_buffer_previewer({
        title = "File Preview",

        get_buffer_by_name = function(_, entry)
            return entry.path
        end,

        define_preview = function(self, entry)
            conf.buffer_previewer_maker(entry.path, self.state.bufnr, {
                bufname = self.state.bufname,
                winid = self.state.winid,
                callback = function(bufnr)
                    vim.api.nvim_buf_clear_namespace(bufnr, replacement_preview_namespace, 0, -1)

                    for _, match in ipairs(entry.matches) do
                        local row = match.lnum - 1
                        local start_col = match.col - 1
                        local end_col = start_col + #entry.old

                        vim.api.nvim_buf_set_extmark(bufnr, replacement_preview_namespace, row, start_col, {
                            end_col = end_col,
                            hl_group = "DiffDelete",
                            priority = 200,
                        })

                        if entry.replacement ~= "" then
                            vim.api.nvim_buf_set_extmark(bufnr, replacement_preview_namespace, row, end_col, {
                                virt_text = {
                                    { entry.replacement, "DiffAdd" },
                                },
                                virt_text_pos = "inline",
                                priority = 200,
                            })
                        end
                    end

                    local first_match = entry.matches[1]

                    if first_match and vim.api.nvim_win_is_valid(self.state.winid) then
                        pcall(vim.api.nvim_win_set_cursor, self.state.winid, { first_match.lnum, first_match.col - 1 })
                        vim.api.nvim_buf_call(bufnr, function()
                            vim.cmd("normal! zz")
                        end)
                    end
                end,
            })
        end,
    })
end

function M.replace_in_scope(opts)
    opts = opts or {}

    local cwd = vim.fs.normalize(opts.cwd or vim.uv.cwd())
    local search_dirs = opts.search_dirs or { cwd }
    local replacement_state = { old = "", replacement = "", lines = {} }

    pickers
        .new(opts, {
            prompt_title = "Replace in Scope (old/new)",
            cwd = cwd,

            finder = finders.new_job(function(prompt)
                local old, replacement = parse_replace_prompt(prompt)

                replacement_state.old = old or ""
                replacement_state.replacement = replacement or ""
                replacement_state.lines = {}

                if not old or old == "" then
                    return nil
                end

                local command = {
                    "rg",
                    "--color=never",
                    "--fixed-strings",
                    "--files-with-matches",
                    "--hidden",
                    "--glob",
                    "!**/.git/**",
                    "--",
                    old,
                }

                vim.list_extend(command, search_dirs)
                return command
            end, replacement_entry_maker(cwd, replacement_state), nil, cwd),

            sorter = sorters.empty(),
            previewer = replacement_previewer(),

            attach_mappings = function(_, map)
                map("i", "<CR>", apply_selected_replacements)
                map("n", "<CR>", apply_selected_replacements)
                map("i", "<C-a>", apply_all_replacements)
                map("n", "<C-a>", apply_all_replacements)

                return true
            end,
        })
        :find()
end

local function entry_maker(cwd)
    local cwd_prefix = cwd .. "/"

    return function(path)
        local absolute_path = vim.fs.normalize(path)

        if not vim.startswith(absolute_path, "/") then
            absolute_path = vim.fs.normalize(cwd_prefix .. absolute_path)
        end

        local relative_path = absolute_path

        if vim.startswith(absolute_path, cwd_prefix) then
            relative_path = absolute_path:sub(#cwd_prefix + 1)
        end

        local is_directory = vim.fn.isdirectory(absolute_path) == 1

        return {
            value = absolute_path,
            path = absolute_path,

            -- Text used for fuzzy matching.
            ordinal = relative_path,

            -- Text displayed in Telescope.
            display = is_directory and relative_path .. "/" or relative_path,
            relative_path = relative_path,

            is_directory = is_directory,
        }
    end
end

function M.find_scope(opts)
    opts = opts or {}

    local cwd = vim.fs.normalize(opts.cwd or vim.uv.cwd())

    pickers
        .new(opts, {
            prompt_title = "Find Scope",
            cwd = cwd,

            finder = finders.new_oneshot_job({
                "fd",
                "--type",
                "file",
                "--type",
                "directory",
                "--exclude",
                ".git",
                ".",
                cwd,
            }, {
                entry_maker = entry_maker(cwd),
            }),

            sorter = conf.file_sorter(opts),

            previewer = previewers.new_buffer_previewer({
                title = "Preview",

                define_preview = function(self, entry)
                    if entry.is_directory then
                        previewer_utils.job_maker(
                            {
                                "tree",
                                "-L",
                                "2",
                                "--",
                                entry.relative_path,
                            },
                            self.state.bufnr,
                            {
                                value = entry.path,
                                bufname = self.state.bufname,
                                cwd = cwd,
                            }
                        )

                        return
                    end

                    conf.buffer_previewer_maker(entry.path, self.state.bufnr, {
                        bufname = self.state.bufname,
                        winid = self.state.winid,
                    })
                end,
            }),

            attach_mappings = function(_, map)
                map("i", "<C-a>", live_grep_selected)
                map("n", "<C-a>", live_grep_selected)
                map("i", "<CR>", live_grep_selected)
                map("n", "<CR>", live_grep_selected)
                map("i", "<C-r>", replace_selected)
                map("n", "<C-r>", replace_selected)

                return true
            end,
        })
        :find()
end

return require("telescope").register_extension({
    exports = {
        find_scope = M.find_scope,
        replace_in_scope = M.replace_in_scope,
    },
})
