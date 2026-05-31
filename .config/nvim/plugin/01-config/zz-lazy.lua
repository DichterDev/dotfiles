local gh = require("util").pack.gh

vim.pack.add({ gh("folke/lazy.nvim") })

local rtp = vim.opt.rtp:get()

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	performance = {
		reset_packpath = false,
		rtp = {
			reset = true,
			paths = rtp,
		},
	},
	rocks = {
		enabled = true,
	},
	change_detection = {
		enabled = false,
	},
})
