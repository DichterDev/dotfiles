---@type vim.lsp.Config
local config = {
	---@type lspconfig.settings.eslint
	settings = {
		eslint = {
			useFlatConfig = true,
		},
	},
}

require("util").lsp.setup("eslint", config)
