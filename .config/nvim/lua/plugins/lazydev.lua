---@module "lazy"
---@type LazySpec
return {
  {
    "folke/lazydev.nvim",
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
    },
    ft = { "lua" },
    opts = {
      library = {
        { path = vim.fn.stdpath("config") .. "/lua", words = { "config" } },
        { path = "luvit-meta/library",               words = { "vim%.uv" } },
        { path = "LazyVim",                          words = { "LazyVim" } },
      },
    },
    config = function(_, opts)
      require("lazydev").setup(opts)
      local ok, lsp = pcall(require, "lazydev.lsp")
      if ok then
        table.insert(lsp.supported_clients, "lua")
      end
    end
  },
}
