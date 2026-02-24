---@type vim.lsp.Config
local lint = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("oxlint", lint)
vim.lsp.enable("oxlint")

---@type vim.lsp.Config
local fmt = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("oxfmt", fmt)
vim.lsp.enable("oxfmt")
