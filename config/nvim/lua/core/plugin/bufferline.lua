local M = {}

function M.setup()
	require("bufferline").setup({
		options = {
			tab_size = 24,
		},
	})
end

return M
