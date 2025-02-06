local M = {}

M.onDebug = function()
    local dapui = require("dapui")
    local terms = require("toggleterm.terminal")
    local treeapi = require("nvim-tree.api")

    -- Close opened term
    local terminals = terms.get_all()
    for _, term in pairs(terminals) do
        term:close()
    end

    -- Close opened file tree
    treeapi.tree.close()

    dapui.open()
end

M.setup = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
        layouts = {
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
            {
                elements = {
                    {
                        id = "repl",
                        size = 1,
                    },
                },
                position = "right",
                size = 80,
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

    -- vim.api.nvim_create_autocmd("FileType", {
    --     callback = function()
    --         print("ok")
    --         vim.cmd("setlocal wrap")
    --         -- vim.cmd("AnsiEsc")
    --     end,
    -- })
    -- vim.api.nvim_create_augroup("WrapLineInTeXFile", { clear = true })

    -- vim.api.nvim_create_autocmd("FileType", {
    --     group = "WrapLineInTeXFile",
    --     pattern = "dap-repl",
    --     command = "setlocal wrap"
    -- })
end

return M
