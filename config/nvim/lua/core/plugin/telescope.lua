local M = {}

function M.setup()
    require('telescope').setup()
    -- local builtin = require('telescope.builtin')
    -- vim.keymap.set('n', '<space>ff', builtin.find_files, {})
    -- vim.keymap.set('n', '<space>fg', builtin.live_grep, {})
    -- vim.keymap.set('n', '<space>fb', builtin.buffers, {})
    -- vim.keymap.set('n', '<space>fh', builtin.help_tags, {})
end

return M
