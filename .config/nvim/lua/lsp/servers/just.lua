---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
	init_options = {
		rules = {
			["unused-variables"] = "off",
			["unused-parameters"] = { level = "warning" },
		},
	},
}

vim.lsp.config("just", config)
vim.lsp.enable("just")
