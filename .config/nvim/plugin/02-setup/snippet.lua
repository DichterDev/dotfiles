local gh = require("util").pack.gh

vim.pack.add({ gh("nvim-mini/mini.nvim") })

require("mini.snippets").setup({
	snippets = {
		require("mini.snippets").gen_loader.from_lang(),
	},
})
