local M = {}

function M.setup()
    local api = require('nvim-tree.api')
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- empty setup using defaults
    require("nvim-tree").setup({
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
    })
    vim.keymap.set('n', '<space>e', api.tree.toggle)
end

return M
