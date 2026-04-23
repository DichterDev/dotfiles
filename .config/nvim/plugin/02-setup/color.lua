local gh = require("util").pack.gh

vim.pack.add({
	gh("rebelot/kanagawa.nvim"),
	gh("darianmorat/gruvdark.nvim"),
	gh("catppuccin/nvim"),
	gh("pankvitek/bonbon.nvim"),
	gh("navarasu/onedark.nvim"),
	gh("scottmckendry/cyberdream.nvim"),
	gh("sainnhe/sonokai"),
})

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
