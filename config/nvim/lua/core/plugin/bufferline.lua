local M = {}

function M.setup()
    local bufferline = require("bufferline")

    local normal = vim.api.nvim_get_hl(0, { name = "ColorColumn" })
    local title_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg

    bufferline.setup({
        options = {
            tab_size = 0, -- or 1
            max_name_length = 999,
            truncate_names = false,
            enforce_regular_tabs = false,
            themable = true,
            separator_style = "slope",
            close_command = "Bdelete! %d",
            -- separator_style = {"", ""},
            indicator = { style = "none" },
            show_buffer_close_icons = false,
            show_close_icon = false,
            always_show_bufferline = true,
            color_icons = true,
            show_buffer_icons = true,
        },
        highlights = {
            fill = { bg = normal.bg, fg = normal.fg },
            buffer_selected = { fg = normal.bg, bg = title_fg },
            separator = { fg = normal.bg, bg = normal.fg },
            separator_selected = { fg = normal.bg, bg = title_fg },
            separator_visible = { fg = normal.bg, bg = normal.fg },
            modified_selected = { bg = title_fg, fg = normal.fg },
        },
    })
end

return M
