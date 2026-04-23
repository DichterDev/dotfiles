local gh = require("util").pack.gh

vim.pack.add({ gh("Aasim-A/scrollEOF.nvim") })

require("scrollEOF").setup({})
