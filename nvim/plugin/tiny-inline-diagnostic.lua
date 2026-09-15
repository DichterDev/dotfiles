require("tiny-inline-diagnostic").setup({
	preset = "powerline",
	hi = {
		error = "DiagnosticError",
		warn = "DiagnosticWarn",
		info = "DiagnosticInfo",
		hint = "DiagnosticHint",
		arrow = "NonText",
		background = "CursorLine",
		mixing_color = "None",
	},
	options = {
		show_source = { enabled = false },
		show_code = false,
		add_messages = {
			display_count = true,
		},
		multilines = {
			enabled = true,
		},
		override_open_float = true,
		virt_texts = {
			priority = 9999,
		},
	},
})
