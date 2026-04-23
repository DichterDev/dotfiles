local gh = require("util").pack.gh

vim.pack.add({
  gh("rebelot/kanagawa.nvim"),
  gh("darianmorat/gruvdark.nvim"),
  gh("catppuccin/nvim"),
})

require("kanagawa").setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
})

require("catppuccin").setup({
  flavour = "macchiato",
})

vim.cmd.colorscheme("kanagawa")
