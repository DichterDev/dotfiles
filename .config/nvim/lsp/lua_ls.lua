---@type vim.lsp.Config
return {
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
