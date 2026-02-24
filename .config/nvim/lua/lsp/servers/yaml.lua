---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("yamlls", config)
vim.lsp.enable("yamlls")
