---@type LazySpec
return {
	{ "3rd/image.nvim", opts = {} },
	{ "saghen/blink.indent", opts = {} },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "Eandrju/cellular-automaton.nvim" },
	{ "catgoose/nvim-colorizer.lua", event = "BufReadPre", opts = {} },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
	{ "pcolladosoto/tinygo.nvim", opts = {} },
	{ "neovim/nvim-lspconfig" },
}
