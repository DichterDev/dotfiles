---@class ParserInfo
---@field name string

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })



    local av = require("nvim-treesitter.parsers")

    for k, _ in pairs(av) do
      av[k].name = k
    end

    local parser = {
      lang = {
        av.c,
        av.cpp,
        av.vim,
        av.lua,
        av.python,
        av.go,
        av.rust,
        av.java,
        av.bash,
        av.fish,
        av.c_sharp,
        av.query,
        av.make,
        av.glsl,
        av.properties,
        av.groovy
      },
      git = {
        av.gitignore,
        av.gitcommit,
        av.gitattributes,
        av.git_config,
        av.git_rebase,
      },
      js = {
        av.jsx,
        av.javascript,
        av.tsx,
        av.typescript,
      },
      web = {
        av.css,
        av.scss,
        av.html,
        av.html_tags,
        av.vue,
      },
      data = {
        av.json,
        av.yaml,
        av.toml
      },
      db = {
        av.sql,
      },
      docker = {
        av.dockerfile,
        av.caddy
      },
      markup = {
        av.typst,
        av.markdown,
        av.markdown_inline
      },
      doc = {
        av.vimdoc,
        av.javadoc,
        av.jsdoc,
      }
    }

    local parsers = {}

    for _, v in pairs(parser) do
      for _, p in pairs(v) do
        table.insert(parsers, p.name)
      end
    end

    ts.install(parsers)

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
