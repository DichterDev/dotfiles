---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("tsgo", config)
vim.lsp.enable("tsgo")
