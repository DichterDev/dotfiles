---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("jsonls", config)
vim.lsp.enable("jsonls")
