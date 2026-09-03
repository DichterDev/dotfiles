PackAdd({
	"gh:kevinhwang91/nvim-ufo",
	"gh:kevinhwang91/promise-async",
})

require("ufo").setup({
	open_fold_hl_timeout = 150,
	close_fold_kinds_for_ft = {
		default = { "imports", "comment" },
	},
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})
