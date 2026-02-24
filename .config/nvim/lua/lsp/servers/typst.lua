---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
	settings = {
		formatterMode = "typstyle",
		exportPdf = "disable",
		semanticTokens = "disable",
	},
}

vim.lsp.config("tinymist", config)
vim.lsp.enable("tinymist")
