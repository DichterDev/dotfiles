---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("fish_lsp", config)
vim.lsp.enable("fish_lsp")
