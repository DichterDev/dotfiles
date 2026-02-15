---@type Server
local M = {}

local defaults = require("lsp.defaults")

M.ignored = true

M.config = require("microprofile.launch").lsp_config({
  capabilties = defaults.capabilities()
})

return M
