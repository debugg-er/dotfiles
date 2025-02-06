local dap = require("dap")

dap.adapters["pwa-node"] = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = "js-debug-adapter",
		args = { "${port}" },
	},
}

dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		-- processId = require("dap.utils").pick_process,
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		-- processId = require("dap.utils").pick_process,
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
	},
}
