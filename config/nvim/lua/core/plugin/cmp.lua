local M = {}

-- function endsWith(str, ending)
--     return ending == "" or str:sub(- #ending) == ending
-- end

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
				mode = "symbol_text",
				before = function(entry, vim_item)
					-- if vim_item.kind == "Method" or vim_item.kind == "Function" then
					--     -- return
					--     if not endsWith(vim_item.abbr, "~") then
					--         vim_item.abbr = vim_item.abbr .. "~"
					--     end
					-- end
					return vim_item
				end,
			}),
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["jl"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{
				name = "nvim_lsp",
				entry_filter = function(entry, ctx)
					local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
					if kind == "Text" then
						return false
					end
					-- if kind == "String" then
					--     return false
					-- end
					return true
				end,
			},
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "cmp_tabnine" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "treesitter" },
			{ name = "crates" },
			{ name = "tmux" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "dap" },
		}, {
			{ name = "buffer" },
		}),
		experimental = {
			ghost_text = true,
		},
	}

	cmp.setup(opts)

	-- local lsp_defaults = lspconfig.util.default_config

	-- lsp_defaults.capabilities = vim.tbl_deep_extend(
	--     'force',
	--     lsp_defaults.capabilities,
	--     require('cmp_nvim_lsp').default_capabilities()
	-- )
end

return M
