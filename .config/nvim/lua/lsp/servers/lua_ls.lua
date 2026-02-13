local M = {}

local default = require("lsp.default")

---@type vim.lsp.Config
M.config = {
  name = "lua_ls",
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json" },
  capabilities = default.capabilities(),
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
