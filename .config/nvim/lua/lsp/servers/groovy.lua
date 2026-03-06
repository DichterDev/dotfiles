---@type vim.lsp.Config
local config = {
	cmd = { "groovy-language-server" },
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("groovyls", config)
vim.lsp.enable("groovyls")
