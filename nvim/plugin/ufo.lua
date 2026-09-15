require("ufo").setup({
	open_fold_hl_timeout = 150,
	close_fold_kinds_for_ft = {
		default = { "imports", "comment", "region" },
	},
	provider_selector = function(bufnr, filetype, buftype)
		-- return { "lsp", "treesitter" }
		return { "lsp", "indent" }
	end,
})
