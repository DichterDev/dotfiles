PackAdd({
	"gh:tpope/vim-dadbod",
	"gh:kristijanhusak/vim-dadbod-ui",
	"gh:kristijanhusak/vim-dadbod-completion",
})

vim.g.db_ui_use_nerd_fonts = 1

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		vim.bo.omnifunc = "vim_dadbod_completion#omni"
	end,
})
