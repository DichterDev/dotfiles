vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.lua" },
	callback = function(ev)
		vim.g.lazydev_enabled = vim.fs.root(vim.fn.stdpath("config") .. "/nvim", ev.file)
	end,
})
