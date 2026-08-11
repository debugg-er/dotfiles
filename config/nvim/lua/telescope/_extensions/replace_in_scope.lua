local function replace_in_scope(opts)
    local telescope = require("telescope")

    if not telescope.extensions.find_scope then
        telescope.load_extension("find_scope")
    end

    telescope.extensions.find_scope.replace_in_scope(opts)
end

return require("telescope").register_extension({
    exports = {
        replace_in_scope = replace_in_scope,
    },
})
