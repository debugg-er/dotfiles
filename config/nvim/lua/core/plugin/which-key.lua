local M = {}

function M.setup()
    local which_key = require("which-key")
    local telescope = require("telescope.builtin")

    vim.o.timeout = true
    vim.o.timeoutlen = 300

    which_key.setup({
        keys = {
            scroll_down = "<C-d>",
            scroll_up = "<C-u>",
        },
        win = {
            border = "rounded",
        },
        disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
        },
    })

    which_key.add({
        -- General
        { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle Comment", icon = "" },
        { "<leader>a", "<cmd>Telescope live_grep<CR>", desc = "Search Workspace", icon = "󰊄" },
        {
            "<leader>A",
            function()
                telescope.live_grep({ additional_args = { "--fixed-strings" } })
            end,
            desc = "Search Fixed String",
            icon = "󰊄",
        },
        { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "Buffers", icon = "󰓩" },
        {
            "<leader>e",
            function()
                Snacks.explorer.open()
            end,
            desc = "Explorer",
            icon = "󰉋",
        },
        { "<leader>f", "<cmd>Telescope find_files hidden=true<CR>", desc = "Find Files", icon = "󰈞" },
        { "<leader>h", "<cmd>nohlsearch<CR>", desc = "Clear Search Highlight", icon = "󰸱" },
        { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit", icon = "󰗼" },
        { "<leader>r", vim.lsp.buf.rename, desc = "Rename Symbol", icon = "󰑕" },
        { "<leader>R", "<cmd>source $MYVIMRC<CR>", desc = "Reload Config", icon = "󰑐" },
        { "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", desc = "Search and Replace", icon = "󰛔" },
        { "<leader>w", "<cmd>w!<CR>", desc = "Save", icon = "󰆓" },

        -- Treesitter
        { "<leader>T", group = "Treesitter", icon = "󰐅" },
        { "<leader>Ti", "<cmd>TSConfigInfo<CR>", desc = "Treesitter Info", icon = "󰋼" },

        -- Debug
        { "<leader>d", group = "Debug", icon = "󰃤" },
        {
            "<leader>d?",
            function()
                require("dapui").eval(nil, { enter = true })
            end,
            desc = "Evaluate Expression",
            icon = "󰃤",
        },
        {
            "<leader>dC",
            function()
                require("dap").run_to_cursor()
            end,
            desc = "Run to Cursor",
            icon = "󰁕",
        },
        {
            "<leader>dU",
            function()
                require("dapui").toggle({ reset = true })
            end,
            desc = "Toggle Debug UI",
            icon = "󰕮",
        },
        {
            "<leader>db",
            function()
                require("dap").step_back()
            end,
            desc = "Step Back",
            icon = "󰜱",
        },
        {
            "<leader>dc",
            function()
                require("dap").continue()
            end,
            desc = "Continue",
            icon = "󰐊",
        },
        {
            "<leader>dd",
            function()
                require("dap").disconnect()
            end,
            desc = "Disconnect",
            icon = "󰅖",
        },
        {
            "<leader>dg",
            function()
                require("dap").session()
            end,
            desc = "Show Session",
            icon = "󰆍",
        },
        {
            "<leader>di",
            function()
                require("dap").step_into()
            end,
            desc = "Step Into",
            icon = "󰆹",
        },
        {
            "<leader>do",
            function()
                require("dap").step_over()
            end,
            desc = "Step Over",
            icon = "󰆸",
        },
        {
            "<leader>dp",
            function()
                require("dap").pause()
            end,
            desc = "Pause",
            icon = "󰏤",
        },
        {
            "<leader>dq",
            function()
                require("dap").close()
            end,
            desc = "Stop Debugging",
            icon = "󰓛",
        },
        {
            "<leader>dr",
            function()
                require("dap").repl.toggle()
            end,
            desc = "Toggle REPL",
            icon = "",
        },
        {
            "<leader>ds",
            function()
                require("dap").continue()
            end,
            desc = "Start Debugging",
            icon = "󰐊",
        },
        {
            "<leader>dt",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle Breakpoint",
            icon = "",
        },
        {
            "<leader>du",
            function()
                require("dap").step_out()
            end,
            desc = "Step Out",
            icon = "󰆺",
        },

        -- Git
        { "<leader>g", group = "Git", icon = "󰊢" },
        { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Switch Branch", icon = "" },
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Browse Commits", icon = "" },
        {
            "<leader>gC",
            "<cmd>Telescope git_bcommits<CR>",
            desc = "Browse File Commits",
            icon = "󰋚",
        },
        { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Diff Against HEAD", icon = "" },
        {
            "<leader>gh",
            "<cmd>Telescope advanced_git_search diff_commit_file<CR>",
            desc = "File History",
            icon = "",
        },
        {
            "<leader>gj",
            function()
                require("gitsigns").next_hunk({ navigation_message = false })
            end,
            desc = "Next Hunk",
            icon = "󰁕",
        },
        {
            "<leader>gk",
            function()
                require("gitsigns").prev_hunk({ navigation_message = false })
            end,
            desc = "Previous Hunk",
            icon = "󰁍",
        },
        {
            "<leader>gl",
            function()
                require("gitsigns").blame_line()
            end,
            desc = "Blame Line",
            icon = "󰊢",
        },
        { "<leader>go", "<cmd>Telescope git_status<CR>", desc = "Changed Files", icon = "" },
        {
            "<leader>gp",
            function()
                require("gitsigns").preview_hunk()
            end,
            desc = "Preview Hunk",
            icon = "󰈈",
        },
        {
            "<leader>gr",
            function()
                require("gitsigns").reset_hunk()
            end,
            desc = "Reset Hunk",
            icon = "󰕌",
        },
        {
            "<leader>gR",
            function()
                require("gitsigns").reset_buffer()
            end,
            desc = "Reset Buffer",
            icon = "󰕌",
        },
        {
            "<leader>gs",
            function()
                require("gitsigns").stage_hunk()
            end,
            desc = "Stage Hunk",
            icon = "󰐕",
        },
        {
            "<leader>gu",
            function()
                require("gitsigns").undo_stage_hunk()
            end,
            desc = "Undo Stage Hunk",
            icon = "󰕌",
        },

        -- LSP
        { "<leader>l", group = "LSP", icon = "󰒋" },
        { "<leader>lI", "<cmd>Mason<CR>", desc = "Mason", icon = "󰏖" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", icon = "󰌵" },
        {
            "<leader>ld",
            "<cmd>Telescope diagnostics bufnr=0 severity_limit=2<CR>",
            desc = "Buffer Diagnostics",
            icon = "󰒡",
        },
        { "<leader>le", "<cmd>Telescope quickfix<CR>", desc = "Quickfix List", icon = "󰁨" },
        {
            "<leader>lj",
            function()
                vim.diagnostic.jump({ count = 1, float = true })
            end,
            desc = "Next Diagnostic",
            icon = "󰒭",
        },
        {
            "<leader>lk",
            function()
                vim.diagnostic.jump({ count = -1, float = true })
            end,
            desc = "Previous Diagnostic",
            icon = "󰒮",
        },
        {
            "<leader>lq",
            function()
                vim.lsp.buf.code_action({ apply = true })
            end,
            desc = "Apply Quick Fix",
            icon = "󰁨",
        },
        {
            "<leader>lw",
            "<cmd>Telescope diagnostics severity_limit=2<CR>",
            desc = "Workspace Diagnostics",
            icon = "󰒡",
        },

        -- Language-specific actions
        { "<leader>ll", group = "Language", icon = "󰗊" },
        { "<leader>llt", group = "TypeScript", icon = "󰛦" },
        {
            "<leader>lltm",
            function()
                vim.lsp.buf.code_action({
                    apply = true,
                    context = {
                        only = { "source.addMissingImports" },
                        diagnostics = {},
                    },
                })
            end,
            desc = "Add Missing Imports",
            icon = "󰋺",
        },
        {
            "<leader>lltx",
            function()
                vim.lsp.buf.code_action({
                    apply = true,
                    context = {
                        only = { "source.removeUnusedImports" },
                        diagnostics = {},
                    },
                })
            end,
            desc = "Remove Unused Imports",
            icon = "󰆴",
        },

        -- Document symbols
        { "<leader>ls", group = "Symbols", icon = "󰘦" },
        {
            "<leader>lsS",
            "<cmd>Telescope lsp_document_symbols symbols=struct symbol_width=60 show_line=true<CR>",
            desc = "Structs",
            icon = "",
        },
        {
            "<leader>lsc",
            "<cmd>Telescope lsp_document_symbols symbols=class symbol_width=60 show_line=true<CR>",
            desc = "Classes",
            icon = "",
        },
        {
            "<leader>lse",
            "<cmd>Telescope lsp_document_symbols symbols=enum symbol_width=60 show_line=true<CR>",
            desc = "Enums",
            icon = "",
        },
        {
            "<leader>lsf",
            "<cmd>Telescope lsp_document_symbols symbols=function symbol_width=60 show_line=true<CR>",
            desc = "Functions",
            icon = "",
        },
        {
            "<leader>lsi",
            "<cmd>Telescope lsp_document_symbols symbols=interface symbol_width=60 show_line=true<CR>",
            desc = "Interfaces",
            icon = "",
        },
        {
            "<leader>lsm",
            "<cmd>Telescope lsp_document_symbols symbols=method symbol_width=60 show_line=true<CR>",
            desc = "Methods",
            icon = "",
        },
        {
            "<leader>lso",
            "<cmd>Telescope lsp_document_symbols symbols=constant symbol_width=60 show_line=true<CR>",
            desc = "Constants",
            icon = "",
        },
        {
            "<leader>lsp",
            "<cmd>Telescope lsp_document_symbols symbols=property symbol_width=60 show_line=true<CR>",
            desc = "Properties",
            icon = "",
        },
        {
            "<leader>lss",
            "<cmd>Telescope lsp_document_symbols symbols=string symbol_width=60 show_line=true<CR>",
            desc = "Strings",
            icon = "",
        },
        {
            "<leader>lsv",
            "<cmd>Telescope lsp_document_symbols symbols=variable symbol_width=60 show_line=true<CR>",
            desc = "Variables",
            icon = "",
        },

        -- Plugins
        { "<leader>p", group = "Plugins", icon = "󰏖" },
        { "<leader>pS", "<cmd>Lazy clear<CR>", desc = "Plugin Status", icon = "󰄬" },
        { "<leader>pc", "<cmd>Lazy clean<CR>", desc = "Clean Plugins", icon = "󰃢" },
        { "<leader>pd", "<cmd>Lazy debug<CR>", desc = "Debug Plugins", icon = "" },
        { "<leader>pi", "<cmd>Lazy install<CR>", desc = "Install Plugins", icon = "󰏔" },
        { "<leader>pl", "<cmd>Lazy log<CR>", desc = "Plugin Log", icon = "󰋚" },
        { "<leader>pp", "<cmd>Lazy profile<CR>", desc = "Profile Plugins", icon = "󰓅" },
        { "<leader>ps", "<cmd>Lazy sync<CR>", desc = "Sync Plugins", icon = "󰓦" },
        { "<leader>pu", "<cmd>Lazy update<CR>", desc = "Update Plugins", icon = "󰚰" },

        -- Search
        { "<leader>s", group = "Search", icon = "󰍉" },
        { "<leader>sb", "<cmd>Telescope git_branches<CR>", desc = "Git Branches", icon = "" },
        { "<leader>sc", "<cmd>Telescope colorscheme<CR>", desc = "Colorschemes", icon = "" },
        { "<leader>sC", "<cmd>Telescope commands<CR>", desc = "Commands", icon = "" },
        { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help Pages", icon = "󰋖" },
        { "<leader>sH", "<cmd>Telescope highlights<CR>", desc = "Highlight Groups", icon = "󰸱" },
        { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps", icon = "󰌌" },
        { "<leader>sl", "<cmd>Telescope resume<CR>", desc = "Resume Search", icon = "󰑎" },
        { "<leader>sM", "<cmd>Telescope man_pages<CR>", desc = "Manual Pages", icon = "󰈙" },
        {
            "<leader>sp",
            function()
                telescope.colorscheme({ enable_preview = true })
            end,
            desc = "Preview Colorscheme",
            icon = "",
        },
        { "<leader>sr", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files", icon = "" },
        { "<leader>sR", "<cmd>Telescope registers<CR>", desc = "Registers", icon = "󰌨" },
    })

    which_key.add({
        mode = "v",

        { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle Comment", icon = "" },

        { "<leader>l", group = "LSP", icon = "󰒋" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", icon = "󰌵" },
    })

    which_key.add({
        -- LSP navigation
        {
            "gD",
            function()
                vim.cmd("vsplit")
                vim.lsp.buf.definition()
            end,
            desc = "Definition in Split",
            icon = "󰤼",
        },
        { "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Go to Definition", icon = "󰈮" },
        { "gi", "<cmd>Telescope lsp_implementations<CR>", desc = "Go to Implementation", icon = "󰡱" },
        { "gr", "<cmd>Telescope lsp_references<CR>", desc = "Go to References", icon = "" },
        { "gt", "<cmd>Telescope lsp_type_definitions<CR>", desc = "Go to Type Definition", icon = "" },

        -- Buffers
        { "ga", group = "Buffers", icon = "󰓩" },
        { "gah", "<cmd>BufferLineCloseLeft<CR>", desc = "Close Buffers to Left", icon = "󰅁" },
        { "gal", "<cmd>BufferLineCloseRight<CR>", desc = "Close Buffers to Right", icon = "󰅂" },
        { "gao", "<cmd>BufferLineCloseOther<CR>", desc = "Close Other Buffers", icon = "󰅖" },
        { "ge", "<cmd>Bdelete<CR>", desc = "Close Buffer", icon = "󰅖" },
    })
end

return M
