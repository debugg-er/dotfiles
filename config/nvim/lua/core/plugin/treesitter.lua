local M = {}

function M.setup()
    require('nvim-ts-autotag').setup()
    require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "dockerfile", "regex" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        -- autotag = {
        --     enable = true,
        --     enable_rename = true,
        --     enable_close = true,
        --     enable_close_on_slash = true,
        --     filetypes = { "html" , "xml" },
        -- }
    })
end

return M
