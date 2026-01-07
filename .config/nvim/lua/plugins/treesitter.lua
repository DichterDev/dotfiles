return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    local parsers = {
      -- CORE
      "c",
      "cpp",
      "lua",
      "vim",
      "vimdoc",
      "query",
      -- WEB
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "scss",
      "vue",
      -- FULL
      "python",
      "java",
      "go",
      "rust",
      -- CONFIG
      "bash",
      "fish",
      -- DATA
      "json",
      "yaml",
      "toml",
      -- DB
      "sql",
      -- MORE
      "dockerfile",
      "markdown",
      "markdown_inline",
      "make",
      "gitignore",
    }

    local filetypes = {
      "c",
      "cpp",
      "lua",
      "vim",
      "javascript",
      "typescript",
      "html",
      "css",
      "python",
      "java",
      "vue",
      "yaml",
      "json",
      "dockerfile",
      "toml",
      "rust",
      "go",
      "markdown",
      "sql"
    }

    ts.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
