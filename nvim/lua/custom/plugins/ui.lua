return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opt = {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require 'custom.configs.ui.bufferline'
    end,
  },
  {
    'felpafel/inlay-hint.nvim',
    event = 'LspAttach',
    config = function()
      require 'custom.configs.ui.inlay-hint'
    end,
  },
  {
    'famiu/bufdelete.nvim',
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {}
    end,
  },
}
