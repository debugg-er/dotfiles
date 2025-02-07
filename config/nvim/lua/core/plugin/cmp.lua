local M = {}

-- function endsWith(str, ending)
--     return ending == "" or str:sub(- #ending) == ending
-- end

function M.setup()
    local cmp = require("cmp")
    local compare = require("cmp.config.compare")
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
                mode = "symbol_text",
                menu = {
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[api]",
                    path = "[path]",
                    luasnip = "[snip]",
                    buffer = "[buf]",
                },
            }),
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
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
            { name = "luasnip" },
            { name = "nvim_lsp_signature_help" },
            { name = "path" },
            { name = "nvim_lua" },
            { name = "dap" },
            { name = "buffer", keyword_length = 6 },
            -- { name = "cmp_tabnine" },
            -- { name = "calc" },
            -- { name = "emoji" },
            -- { name = "treesitter" },
            -- { name = "crates" },
            -- { name = "tmux" },
        }),
        experimental = {
            ghost_text = true,
        },
        sorting = {
            priority_weight = 1.0,
            comparators = {
                compare.offset,
                compare.exact,
                compare.score,
                compare.recently_used,
                compare.locality,
                compare.kind,
                compare.sort_text,
                compare.length,
                compare.order,
            },
        },
    }

    cmp.setup(opts)

    vim.keymap.set({ "i" }, "<C-K>", function()
        luasnip.expand()
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-L>", function()
        luasnip.jump(1)
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-J>", function()
        luasnip.jump(-1)
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end, { silent = true })

    require("luasnip.loaders.from_vscode").lazy_load()

    -- local lsp_defaults = lspconfig.util.default_config

    -- lsp_defaults.capabilities = vim.tbl_deep_extend(
    --     'force',
    --     lsp_defaults.capabilities,
    --     require('cmp_nvim_lsp').default_capabilities()
    -- )
end

return M
