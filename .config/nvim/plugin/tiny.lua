PackAdd({
	"gh:rachartier/tiny-cmdline.nvim",
	"gh:rachartier/tiny-glimmer.nvim",
	"gh:rachartier/tiny-inline-diagnostic.nvim",
})

require("vim._core.ui2").enable({})

vim.o.cmdheight = 0

---@diagnostic disable: missing-fields
require("tiny-cmdline").setup({ on_reposition = require("tiny-cmdline").adapters.blink })
---@diagnostic enable: missing-fields

Autocmd("ColorScheme", "tiny-cmdline-colorscheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "TinyCmdlineNormal", { link = "NormalFloat", update = true })
	end,
})

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

require("tiny-glimmer").setup({
	overwrite = {
		yank = {
			default_animation = "pulse",
		},
		paste = {
			enabled = true,
			default_animation = "reverse_fade",
			paste_mapping = "p",
			Paste_mapping = "P",
		},
		undo = {
			enabled = true,
			default_animation = {
				name = "pulse",
				settings = {
					from_color = "DiffDelete",
					max_duration = 500,
					min_duration = 500,
				},
			},
			undo_mapping = "u",
		},
		redo = {
			enabled = true,
			default_animation = {
				name = "fade",
				settings = {
					from_color = "DiffAdd",
					max_duration = 500,
					min_duration = 500,
				},
			},
			redo_mapping = "<c-r>",
		},
	},
})
