local M = {}

function M.setup()
    require('core.plugin.dap.javascript')
    require('core.plugin.dap.go')
end

return M
