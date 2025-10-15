local function set_pmenu_transparent()
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none" })
end

return {
  {
    "darianmorat/gruvdark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvdark").setup({
        transparent = true
      })
      set_pmenu_transparent()
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
      set_pmenu_transparent()
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
      set_pmenu_transparent()
    end
  }
}
