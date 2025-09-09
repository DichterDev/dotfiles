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
    source = "always",
  },
}

vim.diagnostic.config(diagnostic_opts)
