PackAdd({
	"gh:nanotee/sqls.nvim",
	"gh:seblyng/roslyn.nvim",
	"gh:neovim/nvim-lspconfig",
	"gh:mfussenegger/nvim-jdtls",
	-- "gh:idelice/nvim-jls",
})

require("roslyn").setup({})

require("jdtls")
