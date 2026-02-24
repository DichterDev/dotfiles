---@type vim.lsp.Config
local ty = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("ty", ty)
vim.lsp.enable("ty")
