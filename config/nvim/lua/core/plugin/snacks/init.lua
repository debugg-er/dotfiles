local M = {}

function M.setup()
    local snacks = require("snacks")

    snacks.setup({
        dashboard = require("core.plugin.snacks.dashboard"),
        rename = { enabled = true },
        explorer = { enabled = true },
        picker = {
            sources = {
                explorer = {
                    hidden = true,
                    ignored = true,
                    layout = {
                        auto_hide = { "input" },
                    },
                    win = {
                        list = {
                            keys = {
                                ["/"] = function()
                                    -- Use Neovim's built-in `/` without triggering this mapping again
                                    vim.api.nvim_feedkeys("/", "n", false)
                                end,
                            },
                        },
                    },
                },
            },
        },
    })

    local function set_hl()
        vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", {
            link = "Normal",
        })
        vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", {
            link = "Comment",
        })
        vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", {
            link = "Added",
        })
    end

    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        callback = set_hl,
    })
end

return M
