return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "html",
        "css",
        "python",
        "java",
      },
      ignore_install = {},
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,            -- `false` will disable the whole extension
        disable = { "markdown" }, -- Disable treesitter for markdown for better compatibility with markdown plugins
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = "<bs>",
          node_decremental = "<bs>",
        },
      },
    })
  end
}
