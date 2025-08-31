local add = { source = "catppuccin/nvim" }

local setup = function()
  require("catppuccin").setup({
    flavour = "macchiato",
    background = {
      light = "latte",
      dark = "macchiato",
    },
    transparent_background = true,
    integrations = {
      nvimtree = true,
      mini = true,
    },
  })
end

return { add = add, setup = setup }
