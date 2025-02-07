local M = {}

function M.setup()
    require("telescope").setup({
        defaults = {
            sorting_strategy = "ascending",
            dynamic_preview_title = true,
            layout_config = {
                prompt_position = "top",
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({})
            }
        }
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("advanced_git_search")
end

return M
