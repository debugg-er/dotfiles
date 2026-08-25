local M = {}

function M.snip()
    require('core.plugin.cmp.snip.typescript')
end

function M.setup()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    local opts = {
        enabled = function()
            return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        formatting = {
            format = lspkind.cmp_format({
                mode = "text",
                menu = {
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[api]",
                    path = "[path]",
                    luasnip = "[snip]",
                    buffer = "[buf]",
                    Codeium = "[AI]",
                },
            }),
        },
        window = {
            completion = {
                border = "rounded",
            },
            documentation = {
                border = "rounded",
            },
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["jl"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "luasnip" },
            { name = "codeium" },
            { name = "path" },
            { name = "nvim_lua" },
            { name = "dap" },
            { name = "buffer", keyword_length = 6 },
        }),
        experimental = {
            ghost_text = false,
        },
        sorting = {
            priority_weight = 1.0,
        },
    }

    cmp.setup(opts)
    M.snip()
end

return M
