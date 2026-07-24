local M = {}

function M.setup()
    local snacks = require("snacks")

    snacks.setup({
        dashboard = require("core.plugin.snacks.dashboard"),
        rename = { enabled = true },
        explorer = { enabled = true },
        picker = {
            sources = {
                explorer = {
                    layout = {
                        auto_hide = { "input" },
                    },
                },
            },
        },
    })
end

return M
