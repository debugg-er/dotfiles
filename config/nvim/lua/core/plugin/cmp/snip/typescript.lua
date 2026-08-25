local ls = require("luasnip")
local f = ls.function_node
local postfix = require("luasnip.extras.postfix").postfix

local function log_snippet(json)
    return f(function(_, parent)
        local expr = parent.snippet.env.POSTFIX_MATCH
        local file = vim.fn.expand("%:t")
        local line = vim.api.nvim_win_get_cursor(0)[1]

        local value = expr

        if json then
            value = string.format("JSON.stringify(%s, null, 2)", expr)
        end

        return string.format("console.log('[%s:%d] %s =', %s)", file, line, expr, value)
    end)
end

ls.add_snippets("typescript", {
    postfix(".log", {
        log_snippet(false),
    }),

    postfix(".logjson", {
        log_snippet(true),
    }),
})
