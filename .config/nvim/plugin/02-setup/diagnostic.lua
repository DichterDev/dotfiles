local gh = require("util").pack.gh

vim.pack.add({ gh("rachartier/tiny-inline-diagnostic.nvim") })

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
		add_messages = {
			display_count = true,
		},
		multilines = {
			enabled = true,
		},
	},
})
