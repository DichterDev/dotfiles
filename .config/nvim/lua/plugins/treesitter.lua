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


    ts.install(parsers)

    parsers = require("nvim-treesitter.parsers")


    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(args)
        local ft = vim.filetype.match({ buf = args.buf })
        if not ft then return end

        local ok, _ = pcall(vim.treesitter.get_parser, args.buf, ft)
        if ok then
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
