---@type vim.lsp.Config
local config = {
	root_markers = { ".git", ".root", "typst.toml" },
	capabilities = require("lsp.defaults").capabilities({}),
	settings = {
		formatterMode = "typstyle",
		exportPdf = "disable",
		semanticTokens = "disable",
	},
}

vim.lsp.config("tinymist", config)
vim.lsp.enable("tinymist")
