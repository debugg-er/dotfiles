local function handleVimEnter()
    local git_dir = vim.fn.finddir(".git", ".;")
    if vim.fn.argc() == 0 and git_dir ~= "" then
        -- require('telescope.builtin').find_files()
    end
end

-- Autocommand to trigger telescope find_files when vim is opened without a file
vim.api.nvim_create_autocmd("VimEnter", {
    callback = handleVimEnter,
})
