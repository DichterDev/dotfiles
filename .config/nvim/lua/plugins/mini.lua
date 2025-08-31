local add = { source = "echasnovski/mini.nvim" }

local setup = function()
  require("mini.statusline").setup({})
  require("mini.pairs").setup({})
  require("mini.ai").setup({})
  require("mini.surround").setup({})
  require("mini.move").setup({})
  require("mini.splitjoin").setup({})
  require("mini.notify").setup({})
  require("mini.icons").setup({})
  require("mini.trailspace").setup({})
end

return { add = add, setup = setup }
