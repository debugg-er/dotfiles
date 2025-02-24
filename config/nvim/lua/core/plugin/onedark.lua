local M = {}

function M.setup()
    local onedark = require("onedark")
    onedark.setup({
        style = "dark",
        transparent = true,
    })
    onedark.load()

    local transparent = "NONE" -- No background for diagnostic indicators

    local c = require("onedark.colors")
    local colors = {
        ScrollbarHandle = { fg = transparent, bg = c.bg1 },
        ScrollbarCursorHandle = { fg = c.fg, bg = c.bg1 },
        ScrollbarCursor = { fg = c.fg, bg = c.bg1 },
        ScrollbarSearchHandle = { fg = c.cyan, bg = c.bg1 },
        ScrollbarErrorHandle = { fg = c.red, bg = c.bg1 },
        ScrollbarWarnHandle = { fg = c.yellow, bg = c.bg1 },
        ScrollbarInfoHandle = { fg = c.purple, bg = c.bg1 },
        ScrollbarHintHandle = { fg = c.purple, bg = c.bg1 },
        ScrollbarMiscHandle = { fg = c.purple, bg = c.bg1 },

        -- Diagnostic scrollbar highlights (no background)
        ScrollbarSearch = { fg = c.cyan, bg = transparent },
        ScrollbarError = { fg = c.red, bg = transparent },
        ScrollbarWarn = { fg = c.yellow, bg = transparent },
        ScrollbarInfo = { fg = c.purple, bg = transparent },
        ScrollbarHint = { fg = c.purple, bg = transparent },
        ScrollbarMisc = { fg = c.purple, bg = transparent },
    }

    for group, opts in pairs(colors) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
