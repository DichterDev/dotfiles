require("mini.animate").setup({
	scroll = { enable = false },
	resize = { enable = false },
	open = { enable = false },
	close = { enable = false },
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
