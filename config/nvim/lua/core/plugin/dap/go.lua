local dap = require("dap")

dap.adapters.go = {
    type = "executable",
    command = "go-debug-adapter",
}

dap.configurations.go = {
    {
        type = "go",
        request = "launch",
        name = "Launch",
        program = "${file}",
        args = {},
        cwd = "${workspaceFolder}",
        dlvToolPath = "/home/khainguyen/.local/share/nvim/mason/bin/dlv",
    },
    {
        type = "go",
        request = "attach",
        name = "Attach to Process",
        processId = require("dap.utils").pick_process,
        dlvToolPath = "/home/khainguyen/.local/share/nvim/mason/bin/dlv",
    },
}
