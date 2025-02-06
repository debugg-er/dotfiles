local M = {}

-- function M.setup()
--     require('gitsigns').setup {
--         signs                        = {
--             add          = { text = '│' },
--             change       = { text = '│' },
--             delete       = { text = '_' },
--             topdelete    = { text = '‾' },
--             changedelete = { text = '~' },
--             untracked    = { text = '┆' },
--         },
--         signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
--         numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
--         linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
--         word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
--         watch_gitdir                 = {
--             follow_files = true
--         },
--         attach_to_untracked          = true,
--         current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
--         current_line_blame_opts      = {
--             virt_text = true,
--             virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
--             delay = 1000,
--             ignore_whitespace = false,
--         },
--         current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
--         sign_priority                = 6,
--         update_debounce              = 100,
--         status_formatter             = nil,   -- Use default
--         max_file_length              = 40000, -- Disable if file is longer than this (in lines)
--         preview_config               = {
--             -- Options passed to nvim_open_win
--             border = 'rounded',
--             style = 'minimal',
--             relative = 'cursor',
--             row = 0,
--             col = 1
--         },
--         yadm                         = {
--             enable = false
--         },
--         on_attach                    = require('core.mapping').git
--     }
-- end

-- return M

local icon = require("core.icon")
local config = {
    active = true,
    on_config_done = nil,
    opts = {
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = icon.BoldLineLeft,
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            change = {
                hl = "GitSignsChange",
                text = icon.BoldLineLeft,
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = icon.Triangle,
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = icon.Triangle,
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = icon.BoldLineLeft,
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil, -- Use default
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
            -- Options passed to nvim_open_win
            border = "rounded",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = { enable = false },
    },
}

M.setup = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup(config.opts)
    if config.on_config_done then
        config.on_config_done(gitsigns)
    end
end

return M
