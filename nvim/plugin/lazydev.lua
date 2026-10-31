require("lazydev").setup({
	enabled = function(root_dir)
		-- return vim.fs.root(vim.fn.stdpath("config"), root_dir)
		return true
	end,
	library = {
		{ path = vim.fn.stdpath("config") .. "/lua", words = { "config" } },
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
		{ path = "nvim-lspconfig", words = { "lspconfig" } },
	},
})
