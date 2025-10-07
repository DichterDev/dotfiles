return {
  {
    "darianmorat/gruvdark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvdark").setup({
        transparent = true
      })
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
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
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        transparent = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        }
      })
      vim.cmd.colorscheme("kanagawa")
    end
  }
}
