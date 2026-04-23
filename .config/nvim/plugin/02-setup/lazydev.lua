local gh = require("util").pack.gh

vim.pack.add({
  gh("folke/lazydev.nvim"),
  gh("Bilal2453/luvit-meta")
})

require("lazydev").setup({
  library = {
    { path = vim.fn.stdpath("config") .. "/lua", words = { "config" } },
    { path = "luvit-meta/library",               words = { "vim%.uv" } },
    { path = "nvim-lspconfig",                   words = { "lspconfig" } }
  },
})
