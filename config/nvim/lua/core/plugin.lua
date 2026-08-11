require("lazy").setup({
    -- {
    --     "scottmckendry/cyberdream.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("cyberdream").setup({ transparent = true, saturation = 0.8 })
    --         vim.cmd.colorscheme("cyberdream")
    --     end,
    -- },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 10000,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                float = {
                    transparent = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    -- {
    --     "navarasu/onedark.nvim",
    --     priority = 1000,
    --     config = require("core.plugin.onedark").setup,
    -- },
    -- lazy.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = require("core.plugin.noice").setup,
        dependencies = {
            "MunifTanjim/nui.nvim",
            { "rcarriga/nvim-notify", opts = { render = "minimal", stages = "static" } },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        config = require("core.plugin.tmux-navigator").setup,
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
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
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
        -- dependencies = {
        --     "SmiteshP/nvim-navic",
        -- },
    },
    -- {
    --     "akinsho/bufferline.nvim",
    --     version = "*",
    --     config = require("core.plugin.bufferline").setup,
    --     dependencies = {
    --         "moll/vim-bbye",
    --         "nvim-tree/nvim-web-devicons",
    --     },
    -- },
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
            "nvim-treesitter/nvim-treesitter-context",
            -- "LiadOz/nvim-dap-repl-highlights",
        },
    },
    -- {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     cmd = { "Neotree" },
    --     config = require("core.plugin.neotree").setup,
    --     dependencies = { "MunifTanjim/nui.nvim" },
    -- },
    {
        "williamboman/mason-lspconfig.nvim",
        config = require("core.plugin.lsp").setup,
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
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
            -- "saadparwaiz1/cmp_luasnip",

            "rcarriga/cmp-dap",
            "onsails/lspkind.nvim",
            "ray-x/cmp-treesitter",
            "Exafunction/codeium.nvim",
            -- {
            --     "L3MON4D3/LuaSnip",
            --     version = "2.*",
            --     build = "make install_jsregexp",
            --     dependencies = {
            --         {
            --             "rafamadriz/friendly-snippets",
            --             config = function()
            --                 require("luasnip.loaders.from_vscode").lazy_load()
            --             end,
            --         },
            --     },
            -- },
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
        "Exafunction/codeium.nvim",
        build = ":Codeium Auth",
        config = require("core.plugin.codeium").setup,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = require("core.plugin.snacks").setup,
        dependencies = {
            {
                "nvim-mini/mini.icons",
                config = function()
                    require("mini.icons").setup()
                end,
            },
        },
    },

    -- Supported plugins
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    -- {
    --     "nvim-tree/nvim-web-devicons",
    --     lazy = true,
    -- },
})
