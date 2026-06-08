require("kanagawa").setup({
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
})

require("catppuccin").setup({
	flavour = "macchiato",
})

require("bonbon").setup({})

vim.cmd.colorscheme("kanagawa")
