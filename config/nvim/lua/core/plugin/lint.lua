local M = {}

function M.setup()
    local time = require("core.util.time")
    local lint = require("lint")

    lint.linters_by_ft = {
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        ["*"] = { "typos" },
    }

    local function callback()
        lint.try_lint()
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = callback,
    })

    vim.api.nvim_create_autocmd({ "TextChanged" }, {
        group = vim.api.nvim_create_augroup("nvim-lint-normal-changed", { clear = true }),
        callback = time.debounce(callback, 200),
    })
end

return M
