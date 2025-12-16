local M = {}

function M.setup()
    require("conform").setup({
        -- log_level = vim.log.levels.TRACE,
        formatters_by_ft = {
            typescript = { "prettierd", "eslint_d" },
            typescriptreact = { "prettierd", "eslint_d" },
            javascript = { "prettierd", "eslint_d" },
            javascriptreact = { "prettierd", "eslint_d" },
            json = { "prettierd", "eslint_d" },
            go = { "gofmt", "goimports" },
            lua = { "stylua" },
            proto = { "buf" },
            nix = { "nixpkgs_fmt" },
            java = { "google_java_format" }
        },
    })

    vim.keymap.set("n", "<A-f>", function()
        print("Formatting...")
        local start_time = vim.fn.reltime() -- Start the timer
        -- require("conform").format({ bufnr = opts.buf, async = false, timeout_ms = 10 * 1000 })
        require("conform").format({ async = false, timeout_ms = 10 * 1000, lsp_fallback = true })
        local end_time = vim.fn.reltime() -- End the timer
        local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time, end_time))
        print(string.format("Formatted in %.3f seconds", elapsed))
    end, opts)
end

return M
