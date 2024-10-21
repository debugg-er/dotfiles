vim.cmd("source ~/.vimrc")

require('core.lazy')
require("core.plugin")
require("core.mapping")
require("core.theme")

-- Autocommand to trigger telescope find_files when vim is opened without a file
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local git_dir = vim.fn.finddir(".git", ".;")
    if vim.fn.argc() == 0 and git_dir ~= "" then
      require('telescope.builtin').find_files()
    end
  end
})
