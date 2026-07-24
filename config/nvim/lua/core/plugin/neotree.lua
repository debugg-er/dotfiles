local M = {}

function M.setup()
    local opts = {
        enable_diagnostics = false,
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,

            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_by_name = {
                    ".git",
                },
            },
            window = {
                mappings = {
                    ["o"] = { "open", nowait = true },
                    ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                    ["oc"] = "none",
                    ["od"] = "none",
                    ["og"] = "none",
                    ["om"] = "none",
                    ["on"] = "none",
                    ["os"] = "none",
                    ["ot"] = "none",
                    ["Oc"] = { "order_by_created", nowait = false },
                    ["Od"] = { "order_by_diagnostics", nowait = false },
                    ["Og"] = { "order_by_git_status", nowait = false },
                    ["Om"] = { "order_by_modified", nowait = false },
                    ["On"] = { "order_by_name", nowait = false },
                    ["Os"] = { "order_by_size", nowait = false },
                    ["Ot"] = { "order_by_type", nowait = false },
                    ["/"] = "none",
                },
            },
        },
        buffer = {
            follow_current_file = { enabled = true },
            window = {
                mappings = {
                    ["o"] = { "open", nowait = true },
                    ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                    ["oc"] = "none",
                    ["od"] = "none",
                    ["og"] = "none",
                    ["om"] = "none",
                    ["on"] = "none",
                    ["os"] = "none",
                    ["ot"] = "none",
                    ["Oc"] = { "order_by_created", nowait = false },
                    ["Od"] = { "order_by_diagnostics", nowait = false },
                    ["Og"] = { "order_by_git_status", nowait = false },
                    ["Om"] = { "order_by_modified", nowait = false },
                    ["On"] = { "order_by_name", nowait = false },
                    ["Os"] = { "order_by_size", nowait = false },
                    ["Ot"] = { "order_by_type", nowait = false },
                    ["/"] = "none",
                },
            },
        },
    }

    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    require("neo-tree").setup(opts)
end

return M
