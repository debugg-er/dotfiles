local M = {}

M.onDebug = function()
    local dapui = require("dapui")

    -- Close opened term
    local terms = require("toggleterm.terminal")
    local terminals = terms.get_all()
    for _, term in pairs(terminals) do
        term:close()
    end

    -- Close opened file tree
    local nvimtree_installed, treeapi = pcall(require, "nvim-tree.api")
    if nvimtree_installed then
        treeapi.tree.close()
    end

    local neotree_installed, neotree_command = pcall(require, "neo-tree.command")
    if neotree_installed then
        neotree_command.execute({ action = "close" })
    end

    dapui.open()
end

function M.setup()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
        layouts = {
            {
                elements = {
                    {
                        id = "repl",
                        size = 0.3,
                    },
                    {
                        id = "console",
                        size = 0.7,
                    },
                },
                position = "right",
                size = 100,
            },
            {
                elements = {
                    {
                        id = "scopes",
                        size = 1,
                    },
                },
                position = "bottom",
                size = 20,
            },
            {
                elements = {
                    {
                        id = "breakpoints",
                        size = 0.33,
                    },
                    {
                        id = "stacks",
                        size = 0.33,
                    },
                    {
                        id = "watches",
                        size = 0.33,
                    },
                },
                position = "left",
                size = 60,
            },
        },
    })

    dap.listeners.before.attach.dapui_config = M.onDebug
    dap.listeners.before.launch.dapui_config = M.onDebug
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    require("nvim-dap-virtual-text").setup()

    require("core.plugin.dap.javascript")
    require("core.plugin.dap.go")

    vim.fn.sign_define(
        "DapBreakpoint",
        { text = "⬤", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
end

return M
