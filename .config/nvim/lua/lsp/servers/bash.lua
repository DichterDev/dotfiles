---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("bashls", config)
vim.lsp.enable("bashls")
