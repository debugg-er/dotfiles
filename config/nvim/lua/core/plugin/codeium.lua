local M = {}

function M.setup()
    require("codeium").setup({
        enable_cmp_source = false,
        virtual_text = {
            enabled = true,
            -- filetypes = {
            --     snacks_picker_input = false,
            --     snacks_input = false,
            --     NvimTree = false,
            --     ["Avante*"] = false,
            -- },
            key_bindings = {
                accept = "<C-c>",
                next = "<C-S-n>",
                prev = "<C-S-p>",
            },
        },
    })
end

return M
