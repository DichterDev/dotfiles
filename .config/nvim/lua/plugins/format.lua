---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettierd", stop_after_first = true },
      typescript = { "prettierd", stop_after_first = true },
      vue = { "prettierd", stop_after_first = true }
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
  },
}
