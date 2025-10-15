return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.statusline").setup({
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = '#a6e3a1', bg = '#1e1e2e', bold = true })
      })
      require("mini.pairs").setup({})
      require("mini.ai").setup({})
      require("mini.surround").setup({})
      require("mini.move").setup({})
      require("mini.splitjoin").setup({})
      require("mini.notify").setup({})
      require("mini.icons").setup({})
      require("mini.trailspace").setup({})
      require("mini.align").setup({})
    end
  },
}
