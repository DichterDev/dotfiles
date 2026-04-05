---@type LazySpec
return {
	{ "3rd/image.nvim", opts = {} },
	{ "saghen/blink.indent", opts = {} },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "Eandrju/cellular-automaton.nvim" },
	{ "catgoose/nvim-colorizer.lua", event = "BufReadPre", opts = {} },
	{ "pcolladosoto/tinygo.nvim", opts = {} },
	{ "neovim/nvim-lspconfig" },
	{ "windwp/nvim-ts-autotag", opts = {} },
	{ "Aasim-A/scrollEOF.nvim", event = { "CursorMoved", "WinScrolled" }, opts = {} },
}
