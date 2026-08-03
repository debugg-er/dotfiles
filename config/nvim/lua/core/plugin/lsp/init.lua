local M = {}

local function auto_install()
    local function check_go()
        return os.execute("go version > /dev/null 2>&1")
    end

    local function check_node()
        return os.execute("node --version > /dev/null 2>&1")
    end

    require("mason-tool-installer").setup({
        ensure_installed = {
            "bash-language-server",
            "buf",
            -- "buf-language-server",
            "checkmake",
            "dockerfile-language-server",
            "json-lsp",
            "sonarlint-language-server",
            "typos",

            "nixpkgs-fmt",

            -- Lua
            "lua-language-server",
            "stylua",

            -- TS/JS
            { "tsgo", condition = check_node },
            { "js-debug-adapter", condition = check_node },
            { "eslint_d", condition = check_node },
            { "prettierd", condition = check_node },
            -- { "nxls", condition = check_node },
            -- { "tailwindcss-language-server", condition = check_node },

            -- Golang
            { "gopls", condition = check_go },
            { "go-debug-adapter", condition = check_go },
            { "delve", condition = check_go },
            { "goimports", condition = check_go },
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
    })
end

local function setup_mason()
    require("mason").setup()
    require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
            "lua_ls",
            "dockerls",
            "bashls",
        },
    })

    auto_install()

    -- vim.lsp.inlay_hint.enable(true)
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim", "require" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false },
            },
        },
    })
end

function M.setup()
    setup_mason()

    -- require("core.plugin.lsp.clangd").setup()
end

return M
