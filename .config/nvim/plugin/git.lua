local gh = require("util").pack.gh

vim.pack.add({ gh("lewis6991/gitsigns.nvim") })

require("gitsigns").setup({})
