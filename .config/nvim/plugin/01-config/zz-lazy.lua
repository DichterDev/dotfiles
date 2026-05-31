local gh = require("util").pack.gh

vim.pack.add({ gh("folke/lazy.nvim") })

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
	},
	performance = {
		reset_packpath = false,
		rtp = {
			reset = false,
		},
	},
	rocks = {
		enabled = true,
	},
	change_detection = {
		enabled = false,
	},
})
