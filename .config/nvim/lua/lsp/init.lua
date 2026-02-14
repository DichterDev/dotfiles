---@class Server
---@field config? vim.lsp.Config
---@field ignored? boolean

local utils = require("core.utils")
local defaults = require("lsp.defaults")

local function start(name)
  local ok, srv = pcall(require, "lsp.servers." .. name)

  ---@cast srv Server
  if not ok then
    return
  end

  if srv.ignored then
    return
  end

  srv.config.capabilities = defaults.capabilities(srv.config.capabilities)

  if srv.config.name then
    name = srv.config.name
  end

  vim.lsp.config(name, srv.config)
  vim.lsp.enable(name)
end

local sdir = utils.fs.get_dir() .. "/servers"
local servers = utils.fs.find_files(sdir)

for _, server in ipairs(servers) do
  local name = vim.fn.fnamemodify(server, ":t:r")
  start(name)
end
