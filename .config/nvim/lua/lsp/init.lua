local function setup(server)
  local defaults = {
    capabilities = require("blink-cmp").get_lsp_capabilities(),
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
    end,
    root_markers = { ".git" },
  }
  local ok, lspconfig = pcall(require, "lsp." .. server)
  config = vim.tbl_deep_extend("force", defaults, ok and lspconfig or {})
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

setup("lua")
setup("css-ls")
setup("html-ls")
setup("dockerls")
setup("rust")
