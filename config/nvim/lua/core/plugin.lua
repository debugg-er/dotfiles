require("lazy").setup({
    "christoomey/vim-tmux-navigator",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "mg979/vim-visual-multi",
    {
        "andrewferrier/debugprint.nvim",
        config = require('core.plugin.debugprint').setup
    },
    {
        "natecraddock/workspaces.nvim",
        config = function()
            require("workspaces").setup({ cd_type = "global", })
        end
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
        init = function()
            vim.g.barbar_auto_setup = true
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = require("core.plugin.treesitter").setup,
        build = ":TSUpdate"
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
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'onsails/lspkind.nvim' },
            { "L3MON4D3/LuaSnip",    version = "2.*", build = "make install_jsregexp" },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = require("core.plugin.null-ls").setup
    },
    {
        "navarasu/onedark.nvim",
        config = require("core.plugin.onedark").setup,
    },
})
