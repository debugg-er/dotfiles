require("lazy").setup({
    "christoomey/vim-tmux-navigator",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "mg979/vim-visual-multi",
    -- "mhinz/vim-startify",
    -- {
    --     'numToStr/Comment.nvim',
    --     lazy = false,
    -- },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        config = require('core.plugin.dap').setup,
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    },
    {
        "aaronhallaert/advanced-git-search.nvim",
        lazy = true,
        config = function()
            require("telescope").load_extension("advanced_git_search")
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "tpope/vim-fugitive",
        },
    },
    {
        'nvim-pack/nvim-spectre',
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    },
    {
        "andrewferrier/debugprint.nvim",
        config = require('core.plugin.debugprint').setup
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = require('core.plugin.which-key').setup,
    },
    {
        'akinsho/toggleterm.nvim',
        config = require('core.plugin.terminal').setup
    },
    {
        "lewis6991/gitsigns.nvim",
        config = require("core.plugin.gitsigns").setup,
        cmd = "Gitsigns",
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = require('core.plugin.autopairs').setup
    },
    {
        "RRethy/vim-illuminate",
        config = require('core.plugin.illuminate').setup
    },
    {
        "NMAC427/guess-indent.nvim",
        config = require('core.plugin.guess-indent').setup
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        config = require('core.plugin.telescope').setup,
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = require('core.plugin.indent-blankline').setup
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        config = require("core.plugin.lualine").setup
    },
    {
        'romgrk/barbar.nvim',
        version = '^1.0.0',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = require("core.plugin.barbar").setup
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = require("core.plugin.treesitter").setup,
        build = ":TSUpdate",
        dependencies = {
            'windwp/nvim-ts-autotag',
            'nvim-treesitter/nvim-treesitter-textobjects'
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = require("core.plugin.tree").setup,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = require("core.plugin.lsp").setup,
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
        },
    },
    {
        'hrsh7th/nvim-cmp',
        config = require("core.plugin.cmp").setup,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'onsails/lspkind.nvim',
            "hrsh7th/cmp-path",
            "ray-x/cmp-treesitter",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            { "L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp" },
        },
    },
    {
        "nvimtools/none-ls.nvim",
        config = require("core.plugin.null-ls").setup,
        dependencies = {
            "nvimtools/none-ls-extras.nvim"
        }
    },
    {
        "navarasu/onedark.nvim",
        config = require("core.plugin.onedark").setup,
    },
})
