local M = {}

function M.toggle_format_on_save()
    local formatOnSave = false

    function _toggle_format_on_save()
        formatOnSave = not formatOnSave
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            if formatOnSave then
                vim.lsp.buf.format({ async = false, timeout = 1000 * 1000 })
            end
        end,
    })
    vim.cmd([[command! ToggleFormatOnSave lua _toggle_format_on_save()]])
end

function M.barbar_switch_tab()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
end

function M.bufferline_switch_tab()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    map("n", "<A-,>", "<Cmd>BufferLineCyclePrev<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferLineCycleNext<CR>", opts)
end

function M.lsp(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>Wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>Wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>Wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<A-f>", function()
        print("Formatting...")
        local start_time = vim.fn.reltime() -- Start the timer
        require("conform").format({ bufnr = opts.buf, async = false, timeout_ms = 10 * 1000 })
        local end_time = vim.fn.reltime() -- End the timer
        local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time, end_time))
        print(string.format("Formatted in %.3f seconds", elapsed))
    end, opts)
end

function M.git()
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            gs.next_hunk()
        end)
        return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            gs.prev_hunk()
        end)
        return "<Ignore>"
    end, { expr = true })

    -- Actions
    -- map('n', '<space>hs', gs.stage_hunk)
    -- map('n', '<space>hr', gs.reset_hunk)
    -- map('v', '<space>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    -- map('v', '<space>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    -- map('n', '<space>hS', gs.stage_buffer)
    -- map('n', '<space>hu', gs.undo_stage_hunk)
    -- map('n', '<space>hR', gs.reset_buffer)
    -- map('n', '<space>hp', gs.preview_hunk)
    -- map('n', '<space>hb', function() gs.blame_line { full = true } end)
    -- map('n', '<space>tb', gs.toggle_current_line_blame)
    -- map('n', '<space>hd', gs.diffthis)
    -- map('n', '<space>hD', function() gs.diffthis('~') end)
    -- map('n', '<space>td', gs.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

function M.setup_clipboard()
    local wsl_distro_name = os.getenv("WSL_DISTRO_NAME")
    if wsl_distro_name ~= nil then
        vim.g.clipboard = {
            name = "win32yank-wsl",
            copy = {
                ["+"] = "win32yank.exe -i --crlf",
                ["*"] = "win32yank.exe -i --crlf",
            },
            paste = {
                ["+"] = "win32yank.exe -o --lf",
                ["*"] = "win32yank.exe -o --lf",
            },
            cache_enabled = true,
        }
    end
end

function M.register_resize()
    vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Increase Window Height" })
    vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Decrease Window Height" })
    vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase Window Width" })
    vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease Window Width" })
end

M.toggle_format_on_save()
-- M.barbar_switch_tab()
M.bufferline_switch_tab()
M.setup_clipboard()
M.register_resize()

return M
