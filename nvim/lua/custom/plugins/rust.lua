return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    dependencies = 'neovim/nvim-lspconfig',
    config = function()
      require 'custom.configs.lsp.rust'
    end,
  },
}
