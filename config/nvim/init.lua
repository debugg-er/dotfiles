vim.cmd("source ~/.vimrc")

require("core.lazy")
require("core.plugin")
require("core.mapping")
require("core.theme")
require("core.event")

local diagnostic_colors = {
    Error = "#ff5f5f",
    Warn = "#ffaf00",
    Info = "#5fd7ff",
    Hint = "#5fff87",
}

for severity, color in pairs(diagnostic_colors) do
    vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. severity, {
        undercurl = true,
        sp = color,
    })
end
