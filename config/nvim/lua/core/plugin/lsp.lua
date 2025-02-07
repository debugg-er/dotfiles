local M = {}

-- function setupSonarLint()
--     local filetypes = { 'typescript', 'typescriptreact' }
--     require('sonarlint').setup({
--         server = {
--             cmd       = {
--                 'sonarlint-language-server',
--                 -- Ensure that sonarlint-language-server uses stdio channel
--                 '-stdio',
--                 '-analyzers',
--                 -- paths to the analyzers you need, using those for python and java in this example
--                 vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
--             },
--             autostart = true,
--             filetypes = filetypes
--         },
--         filetypes = filetypes
--     })
-- end

local function setupMason()
    require("mason").setup()
    require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = { "lua_ls", "dockerls", "bashls" },
    })

    -- local handlers = {
    --     ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    --     ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    -- }

    local function on_attach(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end
    end

    -- setupSonarLint()

    require("mason-lspconfig").setup_handlers({
        function(server_name)
            if server_name == "tsserver" then
                require("lspconfig")[server_name].setup({
                    -- handlers = handlers,
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    root_dir = require("lspconfig.util").root_pattern(".git"),
                    filetypes = { "javascript", "javascriptreact" },
                    on_attach = on_attach,
                })
            else
                require("lspconfig")[server_name].setup({
                    -- handlers = handlers,
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    on_attach = on_attach,
                })
            end
        end,
    })

    require("lspconfig").lua_ls.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "require" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    })
end

local function lspKeymap()
    -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
            require("core.mapping").lsp(ev)
        end,
    })
end

function M.setup()
    setupMason()
    lspKeymap()

    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ffff00" })
end

return M
