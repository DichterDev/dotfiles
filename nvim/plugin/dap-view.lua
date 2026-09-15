require("dap-view").setup({
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
