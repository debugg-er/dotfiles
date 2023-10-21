local M = {}

function M.setup()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
        sources = {
            null_ls.builtins.diagnostics.eslint_d,

            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.formatting.eslint_d,
            null_ls.builtins.formatting.beautysh,

            null_ls.builtins.completion.spell,
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                -- vim.lsp.buf.format({ timeout_ms = 10 * 1000 })
                -- vim.api.nvim_create_autocmd("BufWritePre", {
                --     group = augroup,
                --     buffer = bufnr,
                --     callback = function()
                --         -- vim.lsp.buf.format({ async = false })
                --     end,
                -- })
            end
        end,
    })
end

return M
