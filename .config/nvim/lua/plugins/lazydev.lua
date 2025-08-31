local add = { source = "folke/lazydev.nvim", name = "lazydev", ft = "lua" }

local setup = function()
  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })
end

return { add = add, setup = setup }
