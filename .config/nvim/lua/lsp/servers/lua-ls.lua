local defaults = require("lsp.defaults")
---@type Server
local M = {}

---@type vim.lsp.Config
M.config = {
  name = "lua_ls",
  cmd = { "lua-language-server" },
  capabilities = defaults.capabilities({}),
  filetypes = { "lua" },
  root_markers = { ".luarc.json" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = false
      },
      completion = {
        callSnippet = "Replace",
      },
      workspace = {
        checkThirdParty = false,
        ignoreDir = {},
      },
      hint = { enable = true, },
      telemetry = { enable = false }
    }
  }
}

return M
