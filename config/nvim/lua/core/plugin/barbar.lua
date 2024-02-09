local M = {}

function M.setup()
    vim.g.barbar_auto_setup = false
    require'barbar'.setup({})
end

return M
