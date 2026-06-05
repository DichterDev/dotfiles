local setup = require("util").lsp.setup

---@type vim.lsp.Config
local config = {
	---@type lspconfig.settings.lua_ls
	settings = {
		Lua = {
			codeLens = { enable = true },
			runtime = {
				version = "LuaJIT",
				pathStrict = false,
			},
			completion = {
				callSnippet = "Replace",
			},
			workspace = {
				checkThirdParty = false,
				ignoreDir = {},
			},
			hint = { enable = true },
			telemetry = { enable = false },
		},
	},
}

---@type vim.lsp.Config
local format = {}

setup("lua_ls", config)
setup("stylua", format)
