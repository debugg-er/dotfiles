require("lazy").setup({
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = require("core.plugin.onedark").setup,
    },
    {
        "christoomey/vim-tmux-navigator",
    },
    {
        "tpope/vim-surround",
    },
    {
        "tpope/vim-commentary",
    },
    {
        "mg979/vim-visual-multi",
        config = require("core.plugin.visual-multi").setup,
    },
    {
        "stevearc/conform.nvim",
        config = require("core.plugin.conform").setup,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = require("core.plugin.lint").setup,
    },
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = require("core.plugin.dap").setup,
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
            },
        },
    },
    {
        "nvim-pack/nvim-spectre",
        lazy = true,
    },
    {
        "andrewferrier/debugprint.nvim",
        -- lazy = true,
        config = require("core.plugin.debugprint").setup,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = require("core.plugin.which-key").setup,
    },
    {
        "akinsho/toggleterm.nvim",
        config = require("core.plugin.terminal").setup,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = require("core.plugin.gitsigns").setup,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = require("core.plugin.autopairs").setup,
    },
    {
        "RRethy/vim-illuminate",
        config = require("core.plugin.illuminate").setup,
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        cmd = { "Telescope" },
        config = require("core.plugin.telescope").setup,
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "nvim-telescope/telescope-ui-select.nvim",
            },
            {
                "aaronhallaert/advanced-git-search.nvim",
                lazy = true,
                dependencies = {
                    "tpope/vim-fugitive",
                },
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = require("core.plugin.indent-blankline").setup,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = require("core.plugin.lualine").setup,
        dependencies = {
            "SmiteshP/nvim-navic",
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        config = require("core.plugin.bufferline").setup,
        dependencies = {
            "moll/vim-bbye",
        },
    },
    {
        "petertriho/nvim-scrollbar",
        config = require("core.plugin.scrollbar").setup,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = require("core.plugin.treesitter").setup,
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- "LiadOz/nvim-dap-repl-highlights",
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = { "Neotree" },
        config = require("core.plugin.neotree").setup,
        dependencies = { "MunifTanjim/nui.nvim" },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = require("core.plugin.lsp").setup,
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            -- "https://gitlab.com/schrieveslaach/sonarlint.nvim",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = require("core.plugin.cmp").setup,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "saadparwaiz1/cmp_luasnip",

            "rcarriga/cmp-dap",
            "onsails/lspkind.nvim",
            "ray-x/cmp-treesitter",
            "Exafunction/codeium.nvim",

            {
                "L3MON4D3/LuaSnip",
                version = "2.*",
                build = "make install_jsregexp",
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
        },
    },
    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript" },
        config = require("core.plugin.lsp.typescript").setup,
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
        },
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end,
        dependencies = {
            {
                "zbirenbaum/copilot.lua",
                config = function()
                    require("copilot").setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                    })
                end,
            },
        },
    },
    -- {
    -- 	"b0o/incline.nvim",
    -- 	config = require("core.plugin.incline").setup,
    -- 	dependencies = {
    -- 		"nvim-tree/nvim-web-devicons",
    -- 		"SmiteshP/nvim-navic",
    -- 	},
    -- },

    -- Supported plugins
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- {
    -- 	"altermo/ultimate-autopair.nvim",
    -- 	event = { "InsertEnter", "CmdlineEnter" },
    -- 	branch = "v0.6",
    -- 	opts = {},
    -- },
    -- {
    -- 	"ellisonleao/gruvbox.nvim",
    -- 	priority = 1000,
    -- 	config = true,
    -- },
    -- {
    -- 	"catppuccin/nvim",
    -- 	name = "catppuccin",
    -- 	priority = 1000,
    -- },
    -- {
    -- 	"sainnhe/sonokai",
    -- },
    -- {
    -- 	"Mofiqul/vscode.nvim",
    -- },
    -- {
    -- 	"nvimtools/none-ls.nvim",
    -- 	config = require("core.plugin.null-ls").setup,
    -- 	dependencies = {
    -- 		"nvimtools/none-ls-extras.nvim",
    -- 	},
    -- },
    -- {
    -- 	"olimorris/onedarkpro.nvim",
    -- 	priority = 1000, -- Ensure it loads first
    -- },
    -- {
    -- 	"romgrk/barbar.nvim",
    -- 	version = "^1.0.0",
    -- 	dependencies = {
    -- 		"lewis6991/gitsigns.nvim",
    -- 		"nvim-tree/nvim-web-devicons",
    -- 	},
    -- 	config = require("core.plugin.barbar").setup,
    -- },
    -- {
    -- 	"mxsdev/nvim-dap-vscode-js",
    -- 	config = require("core.plugin.dap").setup,
    -- 	dependencies = {
    -- 		"mfussenegger/nvim-dap",
    -- 		{
    -- 			"microsoft/vscode-js-debug",
    -- 			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    -- 		},
    -- 	},
    -- },
    -- {
    -- 	"leoluz/nvim-dap-go",
    -- 	config = require("core.plugin.dap-go").setup,
    -- 	dependencies = {
    -- 		"mfussenegger/nvim-dap",
    -- 	},
    -- },
    -- {
    -- 	"tpope/vim-fugitive",
    -- },
    -- {
    -- 	"nvim-neo-tree/neo-tree.nvim",
    -- 	branch = "v3.x",
    -- 	config = require("core.plugin.neotree").setup,
    -- 	dependencies = {
    -- 		"nvim-lua/plenary.nvim",
    -- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    -- 		"MunifTanjim/nui.nvim",
    -- 		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    -- 	},
    -- },
    -- {
    -- 	"nvim-tree/nvim-tree.lua",
    -- 	config = require("core.plugin.tree").setup,
    -- },
    -- {
    -- 	"NMAC427/guess-indent.nvim",
    -- 	config = require("core.plugin.guess-indent").setup,
    -- },
})
