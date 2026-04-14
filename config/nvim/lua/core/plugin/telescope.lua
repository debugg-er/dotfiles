local M = {}

-- local telescope = require("telescope")

function M.setup()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local grep_selected_files = function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local selections = picker:get_multi_selection()

        -- fallback: if nothing selected, use current entry
        if vim.tbl_isempty(selections) then
            table.insert(selections, action_state.get_selected_entry())
        end

        local files = {}
        for _, entry in ipairs(selections) do
            print(entry.path or entry.filename)
            table.insert(files, entry.path or entry.filename)
        end

        actions.close(prompt_bufnr)

        require("telescope.builtin").live_grep({
            search_dirs = files,
        })
    end

    require("telescope").setup({
        defaults = {
            file_ignore_patterns = { "%.git/" },
            sorting_strategy = "ascending",
            dynamic_preview_title = true,
            layout_config = {
                prompt_position = "top",
            },
            mappings = {
                i = {
                    ["<C-g>"] = grep_selected_files,
                },
                n = {
                    ["<C-g>"] = grep_selected_files,
                },
            },
        },
        pickers = {
            live_grep = {
                additional_args = function(opts)
                    return { "--hidden" }
                end,
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("advanced_git_search")
end

return M
