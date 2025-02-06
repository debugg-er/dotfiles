local M = {}

function M.debounce(func, wait)
    local timer = nil
    return function(...)
        local args = { ... }
        if timer then
            timer:stop()
        end
        timer = vim.defer_fn(function()
            func(unpack(args))
        end, wait)
    end
end

return M
