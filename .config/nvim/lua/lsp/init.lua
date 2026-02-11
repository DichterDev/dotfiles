local utils = require("core.utils")

local function setup(server)
  local defaults = {
    capabilities = require("blink-cmp").get_lsp_capabilities(),
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
    end,
    root_markers = { ".git" },
  }
  local ok, lspconfig = pcall(require, "lsp.servers." .. server)

  if (ok == false or lspconfig.enabled == false) then
    return
  end

  local config = vim.tbl_deep_extend("force", defaults, lspconfig)
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

local server_path = utils.get_dir() .. "/servers"
local servers = utils.find_files(server_path)

for _, server in ipairs(servers) do
  local name = vim.fn.fnamemodify(server, ":t:r")
  setup(name)
end
