local gh = require("util").pack.gh

vim.pack.add({
	gh("seblyng/roslyn.nvim"),
})

require("roslyn").setup({})
