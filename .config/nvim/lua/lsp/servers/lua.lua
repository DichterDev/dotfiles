---@type vim.lsp.Config
local config = {
	capabilities = require("lsp.defaults").capabilities({}),
	settings = {
		Lua = {
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

vim.lsp.config("lua_ls", config)
vim.lsp.enable("lua_ls")
