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
    }

    ts.install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '<filetype>' },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
