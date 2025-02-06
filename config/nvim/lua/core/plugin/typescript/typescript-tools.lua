local M = {}

function M.setup()
	vim.api.nvim_create_user_command("NxInit", function()
		print("Running nx init...")
		-- call nx deamon with graph request
		local now = tostring(os.time())
		local fileName = string.format("%s_graph.json", now)
		local cmd = string.format("npx nx graph --file=%s", fileName)
		os.execute(cmd)

		-- read the file into memory
		local projectGraphFile = io.open(fileName, "r")
		if projectGraphFile then
			-- read project graph from file
			local projectGraph = vim.json.decode(projectGraphFile:read("*a"))
			projectGraphFile:close()

			-- get typescript-tools lsp client
			local lspClients = vim.lsp.get_active_clients()
			local tsclient
			for _, client in ipairs(lspClients) do
				if client.name == "typescript-tools" then
					tsclient = client
				end
			end
			if not tsclient then
				print("typescript-tools.nvim not active")
				return
			end

			-- get workspace root
			-- always first? alternatives to get absolute workspace root?
			local workspacePath = tsclient.config.workspace_folders[1].name
			if not workspacePath then
				print("Could not figure out workspace path")
				return
			end

			-- create external files for monodon
			local externalFiles = {}
			for _, project in pairs(projectGraph.graph.nodes) do
				local sourceRoot = project.data.sourceRoot

				-- skip the root
				if sourceRoot ~= "." then
					-- localte the entry file. perhaps use tsconfig.[app|lib].json
					local mainFile
					if
						project.data
						and project.data.targets
						and project.data.targets.build
						and project.data.targets.build.options
						and project.data.targets.build.options.main
					then
						mainFile = workspacePath .. "/" .. project.data.targets.build.options.main
					else
						mainFile = workspacePath .. "/" .. sourceRoot .. "/index.ts"
					end

					-- insert to config
					table.insert(externalFiles, {
						mainFile = mainFile, -- this is not always index.ts!
						directory = workspacePath .. "/" .. sourceRoot,
					})
				end
			end

			-- send configuration request of monodon plugin to tsserver
			local constants = require("typescript-tools.protocol.constants")
			local method = constants.CustomMethods.ConfigurePlugin
			local args = {
				pluginName = "@monodon/typescript-nx-imports-plugin",
				configuration = {
					externalFiles = externalFiles,
				},
			}
			tsclient.request(method, args, function()
				print("tsserver handled configuration request", method)
			end)

			-- remove the graph file
			os.remove(fileName)
		end
	end, {})

	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	}
	local nxPath = require("lspconfig.util").root_pattern(".git")(vim.fn.getcwd()) .. "/nx.json"

	local function on_attach(client, bufnr)
		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end
	end

	local opts = {
		on_init = function(client, bufnr)
			local stat = vim.loop.fs_stat(nxPath)
			if stat then
				vim.schedule(function()
					vim.cmd.NxInit()
				end)
			end
		end,
		handlers = handlers,
		on_attach = on_attach,
		root_dir = require("lspconfig.util").root_pattern(".git"),
		settings = {
			-- spawn additional tsserver instance to calculate diagnostics on it
			separate_diagnostic_server = true,
			-- "change"|"insert_leave" determine when the client asks the server about diagnostic
			publish_diagnostic_on = "insert_leave",
			-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
			-- "remove_unused_imports"|"organize_imports") -- or string "all"
			-- to include all supported code actions
			-- specify commands exposed as code_actions
			expose_as_code_action = {},
			-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
			-- not exists then standard path resolution strategy is applied
			tsserver_path = nil,
			-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
			-- (see 💅 `styled-components` support section)
			tsserver_plugins = {
				"@monodon/typescript-nx-imports-plugin",
			},
			-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
			-- memory limit in megabytes or "auto"(basically no limit)
			tsserver_max_memory = "auto",
			-- described below
			tsserver_format_options = {},
			tsserver_file_preferences = {},
			-- locale of all tsserver messages, supported locales you can find here:
			-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
			tsserver_locale = "en",
			-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
			complete_function_calls = false,
			include_completions_with_insert_text = true,
			-- CodeLens
			-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
			-- possible values: ("off"|"all"|"implementations_only"|"references_only")
			code_lens = "off",
			-- by default code lenses are displayed on all referencable values and for some of you it can
			-- be too much this option reduce count of them by removing member references from lenses
			disable_member_code_lens = true,
			-- JSXCloseTag
			-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
			-- that maybe have a conflict if enable this feature. )
			jsx_close_tag = {
				enable = false,
				filetypes = { "javascriptreact", "typescriptreact" },
			},
		},
	}
	require("typescript-tools").setup(opts)
end

return M
