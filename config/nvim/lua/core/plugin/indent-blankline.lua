local M = {}

function M.setup()
    require("ibl").setup {
        scope = {
            show_start = false
        }
    }
end

return M
