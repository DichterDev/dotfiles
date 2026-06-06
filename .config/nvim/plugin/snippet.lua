PackAdd("gh:nvim-mini/mini.nvim")

require("mini.snippets").setup({
	snippets = {
		require("mini.snippets").gen_loader.from_lang(),
	},
})
