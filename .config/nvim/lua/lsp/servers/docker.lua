---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("docker_language_server", config)
vim.lsp.enable("docker_language_server")
