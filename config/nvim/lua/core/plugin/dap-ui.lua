local M = {}

M.setup = function()
    require('dapui').setup({
        layouts = {
            {
                elements = {
                    {
                        id = "scopes",
                        size = 0.25
                    },
                    {
                        id = "breakpoints",
                        size = 0.25
                    },
                    {
                        id = "stacks",
                        size = 0.25
                    },
                    {
                        id = "watches",
                        size = 0.25
                    }
                },
                position = "left",
                size = 40
            },
            {
                elements = {
                    {
                        id = "repl",
                        size = 0.5
                    }
                },
                position = "right",
                size = 80
            }
        },
    })
end

return M
