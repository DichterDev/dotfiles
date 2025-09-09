return {
  {
    "darianmorat/gruvdark.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      require("gruvdark").setup({
        transparent = true
      })
      vim.cmd.colorscheme("gruvdark")
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      require("catppuccin").setup({
        flavour = "macchiato",
        background = {
          light = "latte",
          dark = "macchiato",
        },
        transparent_background = true,
        float = {
          transparent = true,
          solid = false
        },
        integrations = {
          nvimtree = true,
          mini = true,
        },
      })
    end
  }
}
