function setup(server)
  local defaults = {
    capabilities = require("blink-cmp").get_lsp_capabilities(),
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
    end,
    root_markers = { ".git" },
  }

  config = vim.tbl_deep_extend("force", defaults, require("lsp." .. server) or {})
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

setup("lua_ls")
