local M = {}

function M.setup()
    vim.lsp.config('clangd', {
        cmd = { "clangd" },
        filetypes = { "c", "cpp" },
    })
    vim.lsp.enable("clangd")
end

return M
