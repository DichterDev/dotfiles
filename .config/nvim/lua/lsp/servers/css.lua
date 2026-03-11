---@type vim.lsp.Config
local css = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("cssls", css)
vim.lsp.enable("cssls")

---@type vim.lsp.Config
local var = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("css_variables", var)
vim.lsp.enable("css_variables")

---@type vim.lsp.Config
local tailwind = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("tailwindcss", tailwind)
vim.lsp.enable("tailwindcss")
