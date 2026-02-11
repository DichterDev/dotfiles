---@type vim.diagnostic.Opts
local diagnostic_opts = {
  signs = true,
  underline = {
    severity = vim.diagnostic.severity.WARN,
  },
  virtual_text = {
    prefix = "●",
  },
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
}

vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#ff5555" })
vim.diagnostic.config(diagnostic_opts)
