local M = {}

local function customizeLogging()
	local js = {
		left = "console.log('",
		right = "')",
		mid_var = "', ",
		right_var = ")",
	}
	require("debugprint").add_custom_filetypes({
		["javascript"] = js,
		["javascriptreact"] = js,
		["typescript"] = js,
		["typescriptreact"] = js,
	})
end

function M.setup()
	local debugprint = require("debugprint")

	debugprint.setup({
		print_tag = " 🚀 ",
	})

	customizeLogging()

	vim.keymap.set("n", "<S-l>", function()
		return require("debugprint").debugprint({ variable = true })
	end, {
		expr = true,
	})
end

return M
