local M = {}

function M.setup()
    require("scrollbar").setup({
        set_highlights = false,
        hide_if_all_visible = true,
        excluded_filetypes = {
            "dropbar_menu",
            "dropbar_menu_fzf",
            "DressingInput",
            "cmp_docs",
            "cmp_menu",
            "noice",
            "prompt",
            "TelescopePrompt",
            "neo-tree",
            "dapui_watches",
            "dapui_stacks",
            "dapui_breakpoints",
            "dapui_scopes",
            "dapui_console",
            "dap-repl",
        },
        handlers = {
            cursor = false,
            diagnostic = true,
            gitsigns = false, -- Requires gitsigns
            handle = true,
            search = false, -- Requires hlslens
            ale = false, -- Requires ALE
        },
    })
end

return M
