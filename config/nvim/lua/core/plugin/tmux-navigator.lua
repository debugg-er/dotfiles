local M = {}

function M.setup()
    vim.keymap.set("n", "<M-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
    vim.keymap.set("n", "<M-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
    vim.keymap.set("n", "<M-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
    vim.keymap.set("n", "<M-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })
    vim.keymap.set("n", "<M-\\>", "<Cmd>TmuxNavigatePrevious<CR>", { silent = true })

    vim.keymap.del("n", "<C-h>")
    vim.keymap.del("n", "<C-j>")
    vim.keymap.del("n", "<C-k>")
    vim.keymap.del("n", "<C-l>")
end

return M
