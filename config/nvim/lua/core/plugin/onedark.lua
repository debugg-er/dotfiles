local M = {}

function M.setup()
    local onedark = require("onedark")
    onedark.setup({
        style = 'dark',
        transparent = true,
    })
    onedark.load()
end

return M
