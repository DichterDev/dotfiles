---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
	settings = {
		tsgo = {
			typescript = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
					importModuleSpecifierEnding = "minimal",
				},
			},
			javascript = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
				},
			},
		},
	},
}

vim.lsp.config("tsgo", config)
vim.lsp.enable("tsgo")
