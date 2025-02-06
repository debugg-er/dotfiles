local M = {}

local config = {
  ---@usage disable which-key completely [not recommended]
  setup = {
    plugins = {
      marks = false,     -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,
        suggestions = 20,
      }, -- use which-key for spelling hints
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false,    -- adds help for operators like d, y, ...
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false,      -- default bindings on <c-w>
        nav = false,          -- misc bindings to work with windows
        z = false,            -- bindings for folds, spelling and others prefixed with z
        g = false,            -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      -- breadcrumb = lvim.icons.ui.DoubleChevronRight,   -- symbol used in the command line area that shows your active key combo
      -- separator = lvim.icons.ui.BoldArrowRight,        -- symbol used between a key and it's label
      -- group = lvim.icons.ui.Plus,                      -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
      border = "single",        -- none, single, double, shadow
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },                                             -- min and max height of the columns
      width = { min = 20, max = 50 },                                             -- min and max width of the columns
      spacing = 3,                                                                -- spacing between columns
      align = "left",                                                             -- align columns left, center or right
    },
    ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                             -- show help message on the command line when the popup is visible
    show_keys = true,                                                             -- show the currently pressed key and its label as a message in the command line
    triggers = "auto",                                                            -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by default for Telescope
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  },

  noPrefixOpts = {
    mode = "n",     -- NORMAL mode
    prefix = "",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  },
  opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  },
  vopts = {
    mode = "v",     -- VISUAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  noPrefixMapping = {
    ["g"] = {
      i = { "<cmd>Telescope lsp_implementations<cr>", "Go to implementations" },
      d = { "<cmd>Telescope lsp_definitions<cr>", "Go to definitions" },
      D = { "<cmd>lua vim.lsp.buf.definition()<cr>:vs<cr><C-o>", "Go to definitions in split" },
      t = { "<cmd>Telescope lsp_type_definitions<cr>", "Go to type definitions" },
      r = { "<cmd>Telescope lsp_references<cr>", "Go to references" },
      e = { "<cmd>Bdelete<CR>", "Close Buffer" },
      a = {
        name = "Buffers",
        o = { "<cmd>BufferLineCloseOther<CR>", "Close all buffers but current" },
        h = { "<cmd>BufferLineCloseLeft<CR>", "Close all buffers to left" },
        l = { "<cmd>BufferLineCloseRight<CR>", "Close all buffers to right" },
      }
    }
  },
  vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    },
  },
  mappings = {
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>confirm q<CR>", "Quit" },
    ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    ["f"] = { "<cmd>Telescope find_files<cr>", "Find in file" },
    ["a"] = { "<cmd>Telescope live_grep<cr>", "Find in workspace" },
    ["r"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    ["S"] = { '<cmd>lua require("spectre").toggle()<cr>', "Spectre replace" },
    d = {
      name = "Debug",
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
    },
    p = {
      name = "Plugins",
      i = { "<cmd>Lazy install<cr>", "Install" },
      s = { "<cmd>Lazy sync<cr>", "Sync" },
      S = { "<cmd>Lazy clear<cr>", "Status" },
      c = { "<cmd>Lazy clean<cr>", "Clean" },
      u = { "<cmd>Lazy update<cr>", "Update" },
      p = { "<cmd>Lazy profile<cr>", "Profile" },
      l = { "<cmd>Lazy log<cr>", "Log" },
      d = { "<cmd>Lazy debug<cr>", "Debug" },
    },

    -- " Available Debug Adapters:
    -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
    -- " Adapter configuration and installation instructions:
    -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    -- " Debug Adapter protocol:
    -- "   https://microsoft.github.io/debug-adapter-protocol/
    -- " Debugging
    g = {
      name = "Git",
      -- g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
      j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = {
        "<cmd>Telescope git_bcommits<cr>",
        "Checkout commit(for current file)",
      },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Git Diff",
      },
      -- advanced_git_search
      h = { "<cmd>Telescope advanced_git_search diff_commit_file<cr>", "Current file history" }
    },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 severity_limit=2<cr>", "Buffer Diagnostics" },
      w = { "<cmd>Telescope diagnostics severity_limit=2<cr>", "Diagnostics" },
      s = {
        name = "LSP Document Symbols",
        m = { "<cmd>Telescope lsp_document_symbols symbols=method symbol_width=60 show_line=true<cr>", "Methods" },
        c = { "<cmd>Telescope lsp_document_symbols symbols=class symbol_width=60 show_line=true<cr>", "Classes" },
        p = { "<cmd>Telescope lsp_document_symbols symbols=property symbol_width=60 show_line=true<cr>", "Properties" },
        e = { "<cmd>Telescope lsp_document_symbols symbols=enum symbol_width=60 show_line=true<cr>", "Enums" },
        i = { "<cmd>Telescope lsp_document_symbols symbols=interface symbol_width=60 show_line=true<cr>", "Interfaces" },
        f = { "<cmd>Telescope lsp_document_symbols symbols=function symbol_width=60 show_line=true<cr>", "Functions" },
        v = { "<cmd>Telescope lsp_document_symbols symbols=variable symbol_width=60 show_line=true<cr>", "Variables" },
        o = { "<cmd>Telescope lsp_document_symbols symbols=constant symbol_width=60 show_line=true<cr>", "Constants" },
        s = { "<cmd>Telescope lsp_document_symbols symbols=string symbol_width=60 show_line=true<cr>", "Strings" },
        S = { "<cmd>Telescope lsp_document_symbols symbols=struct symbol_width=60 show_line=true<cr>", "Structs" },
      },
      -- f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },
      -- i = { "<cmd>Telescope lsp_implementations<cr>", "Go to implementations" },
      -- d = { "<cmd>Telescope lsp_definitions<cr>", "Go to definitions" },
      I = { "<cmd>Mason<cr>", "Mason Info" },
      j = {
        "<cmd>lua vim.diagnostic.goto_next()<cr>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        "Prev Diagnostic",
      },
      l = {
        name = "Language features",
        t = {
          name = "Typescript",
          o = { "<cmd>TSToolsOrganizeImports<cr>", "Sorts and removes unused imports" },
          s = { "<cmd>TSToolsSortImports<cr>", "Sorts imports" },
          r = { "<cmd>TSToolsRemoveUnusedImports<cr>", "Removes unused imports" },
          m = { "<cmd>TSToolsAddMissingImports<cr>", "Add missing imports" },
        }
        -- 
      },
      -- q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      q = { "<cmd>lua vim.lsp.buf.code_action({ apply = true })<cr>", "Quickfix" },
      -- r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      -- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      -- S = {
      --   "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      --   "Workspace Symbols",
      -- },
      e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    },
    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<cr>", "Choose colorscheme" },

      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      -- t = { "<cmd>Telescope live_grep<cr>", "Text" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      l = { "<cmd>Telescope resume<cr>", "Resume last search" },
      p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
    },
    T = {
      name = "Treesitter",
      i = { ":TSConfigInfo<cr>", "Info" },
    },
  },
}

function M.setup()
  local which_key = require("which-key")

  vim.o.timeout = true
  vim.o.timeoutlen = 300

  which_key.setup(config.setup)

  which_key.register(config.mappings, config.opts)
  which_key.register(config.vmappings, config.vopts)
  which_key.register(config.noPrefixMapping, config.noPrefixOpts)
end

return M
