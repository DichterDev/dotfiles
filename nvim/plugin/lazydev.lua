require("lazydev").setup({
	enabled = function(root_dir)
		-- if vim.startswith(root_dir, vim.fn.stdpath("config")) then
		-- 	return true
		-- end
		--
		-- return vim.uv.fs_stat(root_dir .. "/.lazydev") ~= nil

		return true
	end,
	library = {
		{ path = vim.fn.stdpath("config") .. "/lua", words = { "config" } },
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
		{ path = "nvim-lspconfig", words = { "lspconfig" } },
	},
})
