local M = {}

function M.setup()
    local which_key = require("which-key")

    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local setup_opts = {
        plugins = {
            marks = false, -- shows a list of your marks on ' and `
            registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true,
                suggestions = 20,
            }, -- use which-key for spelling hints
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = false, -- adds help for operators like d, y, ...
                motions = false, -- adds help for motions
                text_objects = false, -- help for text objects triggered after entering an operator
                windows = false, -- default bindings on <c-w>
                nav = false, -- misc bindings to work with windows
                z = false, -- bindings for folds, spelling and others prefixed with z
                g = false, -- bindings for prefixed with g
            },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        -- key_labels = {
        --     -- override the label used to display some keys. It doesn't effect WK in any other way.
        --     -- For example:
        --     -- ["<space>"] = "SPC",
        --     -- ["<cr>"] = "RET",
        --     -- ["<tab>"] = "TAB",
        -- },
        icons = {
            -- breadcrumb = lvim.icons.ui.DoubleChevronRight,   -- symbol used in the command line area that shows your active key combo
            -- separator = lvim.icons.ui.BoldArrowRight,        -- symbol used between a key and it's label
            -- group = lvim.icons.ui.Plus,                      -- symbol prepended to a group
        },
        keys = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        win = {
            no_overlap = true,
            -- width = 1,
            -- height = { min = 4, max = 25 },
            -- col = 0,
            -- row = math.huge,
            -- border = "none",
            padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
            title = true,
            title_pos = "center",
            zindex = 1000,
            -- Additional vim.wo and vim.bo options
            bo = {},
            wo = {
                -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
            },
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
        },
        -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true, -- show help message on the command line when the popup is visible
        show_keys = true, -- show the currently pressed key and its label as a message in the command line
        -- triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        -- triggers_blacklist = {
        --     -- list of mode / prefixes that should never be hooked by WhichKey
        --     -- this is mostly relevant for key maps that start with a native binding
        --     -- most people should not need to change this
        --     i = { "j", "k" },
        --     v = { "j", "k" },
        -- },
        -- disable the WhichKey popup for certain buf types and file types.
        -- Disabled by default for Telescope
        disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
        },
    }

    which_key.setup(setup_opts)

    which_key.add({
        {
            "<leader>/",
            "<Plug>(comment_toggle_linewise_current)",
            desc = "Comment toggle current line",
            nowait = true,
            remap = false,
        },
        { "<leader>R", "<cmd>source $MYVIMRC<cr>", desc = "Reload config", nowait = true, remap = false },
        {
            "<leader>S",
            '<cmd>lua require("spectre").toggle()<cr>',
            desc = "Spectre replace",
            nowait = true,
            remap = false,
        },
        { "<leader>T", group = "Treesitter", nowait = true, remap = false },
        { "<leader>Ti", ":TSConfigInfo<cr>", desc = "Info", nowait = true, remap = false },
        { "<leader>a", "<cmd>Telescope live_grep<cr>", desc = "Find in workspace", nowait = true, remap = false },
        { "<leader>d", group = "Debug", nowait = true, remap = false },
        {
            "<leader>d?",
            "<cmd>lua require('dapui').eval(nil, { enter = true })<cr>",
            desc = "Evaluate",
            nowait = true,
            remap = false,
        },
        {
            "<leader>dC",
            "<cmd>lua require'dap'.run_to_cursor()<cr>",
            desc = "Run To Cursor",
            nowait = true,
            remap = false,
        },
        {
            "<leader>dU",
            "<cmd>lua require'dapui'.toggle({reset = true})<cr>",
            desc = "Toggle UI",
            nowait = true,
            remap = false,
        },
        { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back", nowait = true, remap = false },
        { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = true, remap = false },
        { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", nowait = true, remap = false },
        { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", nowait = true, remap = false },
        { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = true, remap = false },
        { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = true, remap = false },
        { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause", nowait = true, remap = false },
        { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", nowait = true, remap = false },
        { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", nowait = true, remap = false },
        { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", nowait = true, remap = false },
        {
            "<leader>dt",
            "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
            desc = "Toggle Breakpoint",
            nowait = true,
            remap = false,
        },
        { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = true, remap = false },
        { "<leader>e", "<cmd>Neotree toggle source=last<CR>", desc = "Explorer", nowait = true, remap = false },
        { "<leader>f", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find in file", nowait = true, remap = false },
        { "<leader>g", group = "Git", nowait = true, remap = false },
        {
            "<leader>gC",
            "<cmd>Telescope git_bcommits<cr>",
            desc = "Checkout commit(for current file)",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gR",
            "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
            desc = "Reset Buffer",
            nowait = true,
            remap = false,
        },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
        { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff", nowait = true, remap = false },
        {
            "<leader>gh",
            "<cmd>Telescope advanced_git_search diff_commit_file<cr>",
            desc = "Current file history",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gj",
            "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
            desc = "Next Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gk",
            "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
            desc = "Prev Hunk",
            nowait = true,
            remap = false,
        },
        { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
        { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
        {
            "<leader>gp",
            "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
            desc = "Preview Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gr",
            "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
            desc = "Reset Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gs",
            "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
            desc = "Stage Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gu",
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            desc = "Undo Stage Hunk",
            nowait = true,
            remap = false,
        },
        { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
        { "<leader>l", group = "LSP", nowait = true, remap = false },
        { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info", nowait = true, remap = false },
        { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
        {
            "<leader>ld",
            "<cmd>Telescope diagnostics bufnr=0 severity_limit=2<cr>",
            desc = "Buffer Diagnostics",
            nowait = true,
            remap = false,
        },
        { "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix", nowait = true, remap = false },
        {
            "<leader>lj",
            "<cmd>lua vim.diagnostic.goto_next()<cr>",
            desc = "Next Diagnostic",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lk",
            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
            desc = "Prev Diagnostic",
            nowait = true,
            remap = false,
        },
        { "<leader>ll", group = "Language features", nowait = true, remap = false },
        { "<leader>llt", group = "Typescript", nowait = true, remap = false },
        {
            "<leader>lltm",
            "<cmd>TSToolsAddMissingImports<cr>",
            desc = "Add missing imports",
            nowait = true,
            remap = false,
        },
        {
            "<leader>llto",
            "<cmd>TSToolsOrganizeImports<cr>",
            desc = "Sorts and removes unused imports",
            nowait = true,
            remap = false,
        },
        { "<leader>lltr", "<cmd>TSToolsRenameFile<cr>", desc = "Rename current file", nowait = true, remap = false },
        { "<leader>llts", "<cmd>TSToolsSortImports<cr>", desc = "Sorts imports", nowait = true, remap = false },
        {
            "<leader>lltx",
            "<cmd>TSToolsRemoveUnusedImports<cr>",
            desc = "Removes unused imports",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lq",
            "<cmd>lua vim.lsp.buf.code_action({ apply = true })<cr>",
            desc = "Quickfix",
            nowait = true,
            remap = false,
        },
        { "<leader>ls", group = "LSP Document Symbols", nowait = true, remap = false },
        {
            "<leader>lsS",
            "<cmd>Telescope lsp_document_symbols symbols=struct symbol_width=60 show_line=true<cr>",
            desc = "Structs",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lsc",
            "<cmd>Telescope lsp_document_symbols symbols=class symbol_width=60 show_line=true<cr>",
            desc = "Classes",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lse",
            "<cmd>Telescope lsp_document_symbols symbols=enum symbol_width=60 show_line=true<cr>",
            desc = "Enums",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lsf",
            "<cmd>Telescope lsp_document_symbols symbols=function symbol_width=60 show_line=true<cr>",
            desc = "Functions",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lsi",
            "<cmd>Telescope lsp_document_symbols symbols=interface symbol_width=60 show_line=true<cr>",
            desc = "Interfaces",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lsm",
            "<cmd>Telescope lsp_document_symbols symbols=method symbol_width=60 show_line=true<cr>",
            desc = "Methods",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lso",
            "<cmd>Telescope lsp_document_symbols symbols=constant symbol_width=60 show_line=true<cr>",
            desc = "Constants",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lsp",
            "<cmd>Telescope lsp_document_symbols symbols=property symbol_width=60 show_line=true<cr>",
            desc = "Properties",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lss",
            "<cmd>Telescope lsp_document_symbols symbols=string symbol_width=60 show_line=true<cr>",
            desc = "Strings",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lsv",
            "<cmd>Telescope lsp_document_symbols symbols=variable symbol_width=60 show_line=true<cr>",
            desc = "Variables",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lw",
            "<cmd>Telescope diagnostics severity_limit=2<cr>",
            desc = "Diagnostics",
            nowait = true,
            remap = false,
        },
        { "<leader>p", group = "Plugins", nowait = true, remap = false },
        { "<leader>pS", "<cmd>Lazy clear<cr>", desc = "Status", nowait = true, remap = false },
        { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean", nowait = true, remap = false },
        { "<leader>pd", "<cmd>Lazy debug<cr>", desc = "Debug", nowait = true, remap = false },
        { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install", nowait = true, remap = false },
        { "<leader>pl", "<cmd>Lazy log<cr>", desc = "Log", nowait = true, remap = false },
        { "<leader>pp", "<cmd>Lazy profile<cr>", desc = "Profile", nowait = true, remap = false },
        { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync", nowait = true, remap = false },
        { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update", nowait = true, remap = false },
        { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit", nowait = true, remap = false },
        { "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
        { "<leader>s", group = "Search", nowait = true, remap = false },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
        { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Find highlight groups", nowait = true, remap = false },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
        { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
        { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
        { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Choose colorscheme", nowait = true, remap = false },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
        { "<leader>sl", "<cmd>Telescope resume<cr>", desc = "Resume last search", nowait = true, remap = false },
        {
            "<leader>sp",
            "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
            desc = "Colorscheme with Preview",
            nowait = true,
            remap = false,
        },
        { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
        { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
    })

    which_key.add({
        mode = { "v" },
        {
            "<leader>/",
            "<Plug>(comment_toggle_linewise_visual)",
            desc = "Comment toggle linewise (visual)",
            nowait = true,
            remap = false,
        },
        { "<leader>l", group = "LSP", nowait = true, remap = false },
        { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
    })

    which_key.add({
        {
            "gD",
            "<cmd>lua vim.lsp.buf.definition()<cr>:vs<cr><C-o>",
            desc = "Go to definitions in split",
            nowait = true,
            remap = false,
        },
        { "ga", group = "Buffers", nowait = true, remap = false },
        { "gah", "<cmd>BufferLineCloseLeft<CR>", desc = "Close all buffers to left", nowait = true, remap = false },
        { "gal", "<cmd>BufferLineCloseRight<CR>", desc = "Close all buffers to right", nowait = true, remap = false },
        {
            "gao",
            "<cmd>BufferLineCloseOther<CR>",
            desc = "Close all buffers but current",
            nowait = true,
            remap = false,
        },
        { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definitions", nowait = true, remap = false },
        { "ge", "<cmd>Bdelete<CR>", desc = "Close Buffer", nowait = true, remap = false },
        {
            "gi",
            "<cmd>Telescope lsp_implementations<cr>",
            desc = "Go to implementations",
            nowait = true,
            remap = false,
        },
        { "gr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references", nowait = true, remap = false },
        {
            "gt",
            "<cmd>Telescope lsp_type_definitions<cr>",
            desc = "Go to type definitions",
            nowait = true,
            remap = false,
        },
    })
end

return M
