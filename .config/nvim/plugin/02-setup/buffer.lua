local gh = require("util").pack.gh
local remove_bg = require("util").hl.remove_bg

vim.pack.add({
	gh("dzfrias/arena.nvim"),
})

require("arena").setup({
	max_items = 15,
	ignore_current = true,
	devicons = true,
	buf_opts = {
		["number"] = false,
		["relativenumber"] = false,
	},
	window = {
		height = 15,
		opts = {
			winhl = "Normal:ArenaNormal,FloatBorder:ArenaFloatBorder",
		},
	},
})

remove_bg("ArenaNormal")
remove_bg("ArenaFloatBorder")

vim.keymap.set("n", "<leader><Tab>", "<CMD>ArenaToggle<CR>", { desc = "toggle [tab] view" })
