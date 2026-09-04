PackAdd({
	"gh:mfussenegger/nvim-dap",
	"gh:mfussenegger/nvim-dap-python",
	"gh:igorlfs/nvim-dap-view",
	"gh:theHamsta/nvim-dap-virtual-text",
})

local dap = require("dap")

local function set_debug_keymaps()
	Map("n", "<Down>", function()
		dap.step_over()
	end, { desc = "Debug: Step Over" })
	Map("n", "<Right>", function()
		dap.step_into()
	end, { desc = "Debug: Step Into" })
	Map("n", "<Left>", function()
		dap.step_out()
	end, { desc = "Debug: Step Out" })
	Map("n", "<Up>", function()
		dap.restart_frame()
	end, { desc = "Debug: Restart Frame" })
end

local function remove_debug_keymaps()
	local arrow_keys = { "<Down>", "<Right>", "<Left>", "<Up>" }
	for _, key in ipairs(arrow_keys) do
		pcall(vim.keymap.del, "n", key)
	end
end

dap.listeners.after.event_initialized["dap_arrow_keymaps"] = function()
	set_debug_keymaps()
end

dap.listeners.before.event_terminated["dap_arrow_keymaps"] = function()
	remove_debug_keymaps()
end

dap.listeners.before.event_exited["dap_arrow_keymaps"] = function()
	remove_debug_keymaps()
end

Map("n", "<F5>", function()
	dap.continue()
end, { desc = "Debug: Start / Continue" })

Map("n", "<S-F5>", function()
	dap.terminate()
end, { desc = "Debug: Stop / Terminate" })

Map("n", "<C-S-F5>", function()
	dap.restart()
end, { desc = "Debug: Restart Session" })

Map("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Debug: Toggle [B]reakpoint" })
Map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional [B]reakpoint" })

Map("n", "<leader>dlp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Debug: Set [L]og [P]oint" })

Map("n", "<leader>dr", function()
	dap.repl.open()
end, { desc = "Debug: Open [R]EPL" })
Map("n", "<leader>dl", function()
	dap.run_last()
end, { desc = "Debug: Run [L]ast" })

local dap_view = require("dap-view")

dap_view.setup({
	winbar = {
		sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
		controls = {
			enabled = true,
		},
	},
	windows = {
		terminal = {
			hide = true,
		},
	},
})

Map("n", "<leader>dv", function()
	dap_view.toggle()
end, { desc = "Debug: Toggle [V]iew" })

dap.listeners.after.event_initialized["dap_view_auto"] = function()
	dap_view.open()
end

dap.listeners.before.event_terminated["dap_view_auto"] = function()
	dap_view.close()
end

dap.listeners.before.event_exited["dap_view_auto"] = function()
	dap_view.close()
end

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
