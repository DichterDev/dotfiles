---@module "lazy"
---@type LazySpec
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      "Bilal2453/luvit-meta",
    },
    opts = {
      library = {
        vim.fn.expand("~/.config/nvim"),
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "LazyVim",            words = { "LazyVim" } },
      },
    },
    config = function(_, opts)
      require("lazydev").setup(opts)
      local ok, lazydev_lsp = pcall(require, "lazydev.lsp")
      if ok then
        lazydev_lsp.supports = function(client)
          return client and vim.tbl_contains({ "lua", "emmylua-analyzer-rust" }, client.name)
        end
      end
    end
  },
  { "Bilal2453/luvit-meta", lazy = true },
}
