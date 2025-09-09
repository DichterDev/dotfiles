return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function ()
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
  },
}
