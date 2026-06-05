local setup = require("util").lsp.setup

---@type vim.lsp.Config
local config = {
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

setup("tsgo", config)
