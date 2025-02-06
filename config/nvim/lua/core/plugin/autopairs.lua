local M = {}

function M.setup()
    local cmp = require("cmp")
    local autopairs = require("nvim-autopairs")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local handlers = require("nvim-autopairs.completion.handlers")

    autopairs.setup()
    cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
            filetypes = {
                ["*"] = {
                    ["("] = {
                        kind = {
                            cmp.lsp.CompletionItemKind.Function,
                            cmp.lsp.CompletionItemKind.Method,
                        },
                        handler = handlers["*"],
                    },
                },
            },
        })
    )
end

return M
