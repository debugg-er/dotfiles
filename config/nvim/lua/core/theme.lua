-- -- ONEDARK
-- local onedark = require("onedark")
-- onedark.setup({
--     style = 'warmer',
--     -- transparent = true,
-- })
-- onedark.load()

-- SONOKAI
-- vim.g.sonokai_colors_override = {
--   bg0 = { "#27292E", 235 },
-- }
-- vim.cmd.colorscheme('sonokai')
-- vim.cmd([[
--     :hi      NvimTreeCursorLine  guibg=#3a3a3a
-- ]])

-- -- VSCODE
-- vim.o.background = 'dark'

-- local c = require('vscode.colors').get_colors()
-- require('vscode').setup({
--     -- Alternatively set style in setup
--     -- style = 'light'

--     -- Enable transparent background
--     transparent = true,

--     -- Enable italic comment
--     italic_comments = true,

--     -- Underline `@markup.link.*` variants
--     underline_links = true,

--     -- Disable nvim-tree background color
--     disable_nvimtree_bg = true,

--     -- Override colors (see ./lua/vscode/colors.lua)
--     color_overrides = {
--         vscLineNumber = '#FFFFFF',
--     },

--     -- Override highlight groups (see ./lua/vscode/theme.lua)
--     group_overrides = {
--         -- this supports the same val table as vim.api.nvim_set_hl
--         -- use colors from this colorscheme by requiring vscode.colors!
--         Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
--     }
-- })
-- -- require('vscode').load()

-- -- load the theme without affecting devicon colors.
-- vim.cmd.colorscheme "vscode"

-- ONEDARK PRO
-- vim.cmd("colorscheme onedark")
