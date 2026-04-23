local gh = require("util").pack.gh

vim.pack.add({ gh("nvim-mini/mini.nvim") })

require("mini.ai").setup({})
require("mini.bracketed").setup({})

require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.align").setup({})
require("mini.splitjoin").setup({})

require("mini.move").setup({})

vim.pack.add({ gh("saghen/blink.indent") })

require("blink.indent").setup({})

vim.pack.add({ gh("HiPhish/rainbow-delimiters.nvim") })

require("rainbow-delimiters")
