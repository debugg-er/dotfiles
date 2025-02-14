local M = {}

function M.custom_linter()
    local sonar_ls_cmd = "sonarlint-language-server"
    require("lint").linters.sonarlint = {
        cmd = function ()
            return sonar_ls_cmd
        end,
        args = {
            "-stdio", -- Use stdio as the transport channel
        },
        stdin = true, -- Send the file content via stdin
        stream = "stdout", -- Read output from stdout
        ignore_exitcode = true, -- Ignore exit code since sonarlint-ls might not follow standard exit codes
        parser = function(output, bufnr)
            -- Parse the output from sonarlint-ls
            -- You might need to adjust this part based on the actual output format of sonarlint-ls
            local result = {}
            -- Example parsing logic (adjust according to the actual output format)
            for _, issue in ipairs(output.issues or {}) do
                table.insert(result, {
                    lnum = issue.line or 1,
                    col = issue.column or 1,
                    message = issue.message or "No message",
                    source = sonar_ls_cmd,
                    severity = issue.severity and vim.diagnostic.severity[issue.severity:upper()]
                        or vim.diagnostic.severity.WARN,
                })
            end
            return result
        end,
    }
end

function M.setup()
    local time = require("core.util.time")
    local lint = require("lint")

    -- M.custom_linter()

    lint.linters_by_ft = {
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        ["*"] = { "typos" },
    }

    local function callback()
        lint.try_lint()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add fallback linters.
        if #names == 0 then
            vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
            local linter = lint.linters[name]
            if not linter then
                error("Linter not found: " .. name)
            end
            return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then
            lint.try_lint(names)
        end
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
