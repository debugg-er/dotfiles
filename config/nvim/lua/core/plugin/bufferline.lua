local M = {}

function M.setup()
    require("bufferline").setup({
        options = {
            tab_size = 24,
            indicator = {
                icon = '',
                style = 'icon'
            },
        },
    })
end

return M
