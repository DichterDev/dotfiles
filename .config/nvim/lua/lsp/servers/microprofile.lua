---@type Server
local M = {}

local defaults = require("lsp.defaults")

M.ignored = true

M.config = require("microprofile.launch").lsp_config({
  capabilities = defaults.capabilities({}),
})

return M
