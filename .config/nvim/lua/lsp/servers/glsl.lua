---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("glsl_analyzer", config)
vim.lsp.enable("glsl_analyzer")
