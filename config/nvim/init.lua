vim.cmd("source ~/.vimrc")

require("core.lazy")
require("core.plugin")
require("core.mapping")
require("core.theme")
require("core.event")

vim.opt.termguicolors = true

vim.diagnostic.config({
    underline = true,
})

local function enable_diagnostic_undercurl()
    for _, severity in ipairs({ "Error", "Warn", "Info", "Hint" }) do
        vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. severity, {
            undercurl = true,
            underline = false,
            update = true,
        })
    end
end

enable_diagnostic_undercurl()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = enable_diagnostic_undercurl,
})
