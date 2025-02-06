local M = {}

function M.setup()
	require("ibl").setup({
		indent = {
			char = "▏",
		},
		scope = {
			show_start = false,
			show_end = false,
		},
	})
end

return M
