local M = {}

function M.setup()
	require("conform").setup({
		formatters_by_ft = {
			typescript = { "prettierd", "eslint_d" },
			javascript = { "prettierd", "eslint_d" },
			json = { "prettierd", "eslint_d" },
			go = { "gofmt", "goimports" },
			lua = { "stylua" },
			proto = { "buf" },
		},
	})
end

return M
