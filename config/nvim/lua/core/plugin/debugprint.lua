local M = {}

local function customizeLogging()
    local js = {
        left = "console.log('",
        right = "')",
        mid_var = "', ",
        right_var = ")",
    }
    require("debugprint").add_custom_filetypes({
        ["javascript"] = js,
        ["javascriptreact"] = js,
        ["typescript"] = js,
        ["typescriptreact"] = js,
    })
end

function M.setup()
    local debugprint = require("debugprint")

    debugprint.setup({
        print_tag = " 🚀 ",
    })

    customizeLogging()

    local debug_variable = function()
        return require("debugprint").debugprint({ variable = true })
    end

    vim.keymap.set({ "n", "v" }, "<S-l>", debug_variable, { expr = true })
end

return M
