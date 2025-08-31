local add = { source = "nvim-treesitter/nvim-treesitter", hooks = { post_checkout = function() vim.cmd("TSUpdate") end } }

local setup = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "html", "css", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true, -- `false` will disable the whole extension
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

return { add = add, setup = setup }
