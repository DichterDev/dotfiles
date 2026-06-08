require("lazydev").setup({
	library = {
		{ path = vim.fn.stdpath("config") .. "/lua", words = { "config" } },
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
		{ path = "nvim-lspconfig", words = { "lspconfig" } },
	},
})
