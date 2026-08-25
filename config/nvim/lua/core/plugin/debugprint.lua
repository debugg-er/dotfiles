local M = {}

function M.setup()
    local debugprint = require("debugprint")

    debugprint.setup({
        keymaps = {
            normal = {
                variable_below = "<S-l>",
            },
            visual = {
                variable_below = "<S-l>",
            },
        },
    })
end

return M
