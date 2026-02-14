---@class Server
---@field config vim.lsp.Config

local utils = require("core.utils")
local defaults = require("lsp.default")

local exclude = { "jdtls" }

local function start(name)
  local ok, srv = pcall(require, "lsp.servers." .. name)
  if not ok then
    vim.notify(name)
    return
  end

  ---@cast srv Server

  vim.lsp.config(name, srv.config)
  vim.lsp.enable(name)
end

local sdir = utils.fs.get_dir() .. "/servers"
local servers = utils.fs.find_files(sdir)

for _, server in ipairs(servers) do
  local name = vim.fn.fnamemodify(server, ":t:r")
  if not vim.tbl_contains(exclude, name) then
    start(name)
  end
end
