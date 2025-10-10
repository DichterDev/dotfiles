local function setup(server)
  local defaults = {
    capabilities = require("blink-cmp").get_lsp_capabilities(),
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
    end,
    root_markers = { ".git" },
  }
  local ok, lspconfig = pcall(require, "lsp." .. server)
  local config = vim.tbl_deep_extend("force", defaults, ok and lspconfig or {})
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

-- NOTE: this function setups all lsps in this directory
local function setup_all()
  local current = debug.getinfo(1, "S").source:sub(2)
  local current_base = vim.fn.fnamemodify(current, ":t")
  local dir = vim.fn.fnamemodify(current, ":h")
  local files = vim.fn.globpath(dir, "*", false, true)
  for _, file in ipairs(files) do
    if vim.fn.isdirectory(file) == 0 then
      local base = vim.fn.fnamemodify(file, ":t")
      if base ~= current_base then
        local server = vim.fn.fnamemodify(base, ":r")
        setup(server)
      end
    end
  end
end

setup_all()
