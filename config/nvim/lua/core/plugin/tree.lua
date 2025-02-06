local M = {}

function M.setup()
	local api = require("nvim-tree.api")
	-- disable netrw at the very start of your init.lua
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- set termguicolors to enable highlight groups
	vim.opt.termguicolors = true

	-- empty setup using defaults
	require("nvim-tree").setup({
		update_focused_file = {
			enable = true,
			-- update_cwd = true
		},
		filters = {
			-- dotfiles = false
		},
		view = {
			width = 45,
			side = "left",
			-- adaptive_size = true
		},
		-- renderer = {
		--     indent_markers = {
		--         enable = true,
		--         icons = {
		--             corner = "└",
		--             edge = "│",
		--             item = "│",
		--             bottom = "─",
		--             none = " ",
		--         }
		--     }
		-- }
	})
	vim.keymap.set("n", "<space>e", api.tree.toggle)
	-- vim.cmd[[autocmd NvimTree_1 highlight NvimTreeIndentMarker     guifg=#444444]]
	-- vim.cmd[[autocmd NvimTree_1 highlight  NvimTreeFolderArrowOpen  guifg=#dddddd]]
end

return M
