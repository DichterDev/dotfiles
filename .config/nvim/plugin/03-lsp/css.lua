local setup = require("util").lsp.setup

---@type vim.lsp.Config
local css = {
	---@type lspconfig.settings.cssls
	settings = {},
}

---@type vim.lsp.Config
local var = {}

---@type vim.lsp.Config
local tailwind = {
	---@type lspconfig.settings.tailwindcss
	settings = {},
}

-- setup("cssls", css)
setup("css_variables", var)
setup("tailwindcss", tailwind)
