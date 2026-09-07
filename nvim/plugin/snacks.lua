PackAdd({ "gh:folke/snacks.nvim" })

require("snacks").setup({
	bigfile = {
		enabled = true,
	},
	image = {
		enabled = true,
		force = true,
		env = {
			TERM_PROGRAM = "kitty",
			ZELLIJ = nil,
		},
		doc = {
			inline = false,
			float = true,
		},
	},
})
