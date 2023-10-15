local M = {}

function M.toggleFormatOnSave()
    local formatOnSave = false

    function toggleFormatOnSaveVar()
        formatOnSave = not formatOnSave
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            print(formatOnSave)
            if formatOnSave then
                vim.lsp.buf.format({ async = false, timeout = 10 * 1000 })
            end
        end,
    })
    vim.cmd([[command! ToggleFormatOnSave lua toggleFormatOnSaveVar()]])
end

function M.barbarSwitchTab()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    map('n', 'gp', '<Cmd>BufferPrevious<CR>', opts)
    map('n', 'gn', '<Cmd>BufferNext<CR>', opts)
end

function M.lsp(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>Wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>Wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>Wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>p', function()
        vim.lsp.buf.format { asynfc = true, timeout = 10 * 1000 }
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
    map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<space>hs', gs.stage_hunk)
    map('n', '<space>hr', gs.reset_hunk)
    map('v', '<space>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('v', '<space>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('n', '<space>hS', gs.stage_buffer)
    map('n', '<space>hu', gs.undo_stage_hunk)
    map('n', '<space>hR', gs.reset_buffer)
    map('n', '<space>hp', gs.preview_hunk)
    map('n', '<space>hb', function() gs.blame_line { full = true } end)
    map('n', '<space>tb', gs.toggle_current_line_blame)
    map('n', '<space>hd', gs.diffthis)
    map('n', '<space>hD', function() gs.diffthis('~') end)
    map('n', '<space>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end


M.toggleFormatOnSave()
M.barbarSwitchTab()

return M
