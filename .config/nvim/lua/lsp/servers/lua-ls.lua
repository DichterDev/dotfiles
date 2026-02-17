local defaults = require("lsp.defaults")
---@type Server
local M = {}

local root_markers = {
	".emmyrc.json",
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
}

vim.list_extend(root_markers, defaults.root_markers)

---@type vim.lsp.Config
M.config = {
	name = "lua_ls",
	cmd = { "lua-language-server" },
	capabilities = defaults.capabilities({}),
	filetypes = { "lua" },
	root_markers = root_markers,
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

return M
