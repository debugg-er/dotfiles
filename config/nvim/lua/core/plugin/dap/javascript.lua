local dap = require("dap")

local input = ""

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}

local configurations = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch - Command",
        outputCapture = "std",
        cwd = vim.fn.getcwd(),
        runtimeExecutable = (function()
            input = vim.fn.input("Enter debug command: ")
            local parts = vim.split(input, " ")
            return parts[1]
        end),
        runtimeArgs = (function()
            local parts = vim.split(input, " ")
            return vim.list_slice(parts, 2)
        end),
    },
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch - yarn start:debug",
        cwd = vim.fn.getcwd(),
        runtimeExecutable = "yarn",
        runtimeArgs = { "start:debug" },
        console = 'integratedTerminal'
    },
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        outputCapture = "std",
    },
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach - Pick Process",
        processId = require("dap.utils").pick_process,
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
    },
}

dap.configurations.typescript = configurations
dap.configurations.javascript = configurations
dap.configurations.typescriptreact = configurations
dap.configurations.javascriptreact = configurations
