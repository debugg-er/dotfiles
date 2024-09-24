local M = {}

function M.setup()
    local dap = require('dap')

    dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
            command = "js-debug-adapter",
            args = { "${port}" },
        }
    }

    dap.configurations.javascript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            runtimeExecutable = "yarn",
            runtimeArgs = { "debug" },
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
    }
    dap.configurations.typescript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            runtimeExecutable = "yarn",
            runtimeArgs = { "api" },
            port = "${port}",
            skipFiles = { "<node_internals>/**" },
            -- program = "${file}",
            cwd = "${workspaceFolder}",
        },
    }

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
