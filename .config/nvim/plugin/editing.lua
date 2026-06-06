PackAdd("gh:nvim-mini/mini.nvim")

require("mini.ai").setup({})
require("mini.bracketed").setup({})

require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.align").setup({})
require("mini.splitjoin").setup({})

require("mini.move").setup({})

PackAdd("gh:saghen/blink.indent")

require("blink.indent").setup({})

PackAdd("gh:HiPhish/rainbow-delimiters.nvim")

require("rainbow-delimiters")
