local dap = require("dap")

require("dap-python").setup("uv")

dap.adapters.codelldb = {
	type = "executable",
	command = "codelldb",
}

dap.configurations.c = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
