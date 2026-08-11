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
                    diagnostics = false,
                    layout = {
                        auto_hide = { "input" },
                    },
                    actions = {
                        toggle_half_width = function(picker)
                            local root = picker.layout.root
                            local win = root.win

                            picker._default_width = picker._default_width or root:size().width
                            picker._double_width = not picker._double_width

                            vim.api.nvim_win_set_width(
                                win,
                                picker._double_width and math.min(picker._default_width * 2, vim.o.columns - 1)
                                    or picker._default_width
                            )
                        end,
                    },
                    win = {
                        list = {
                            keys = {
                                ["/"] = function()
                                    -- Use Neovim's built-in `/` without triggering this mapping again
                                    vim.api.nvim_feedkeys("/", "n", false)
                                end,
                                e = "toggle_half_width",
                            },
                        },
                    },
                },
            },
        },
    })

    local function set_hl()
        -- vim.api.nvim_set_hl(0, "SnacksPickerList", {
        --     link = "Normal",
        -- })
        vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", {
            link = "Normal",
        })
        vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", {
            link = "Comment",
        })
        vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", {
            link = "Added",
        })
        vim.api.nvim_set_hl(0, "CursorLine", {
            link = "Visual",
        })
    end

    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        callback = set_hl,
    })
end

return M
