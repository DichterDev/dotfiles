require("mini.ai").setup({})
require("mini.bracketed").setup({})

require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.align").setup({})
require("mini.splitjoin").setup({})

require("mini.move").setup({})

require("blink.indent").setup({})

require("rainbow-delimiters")

require("spider").setup()

vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>")

require("precognition").setup({
	startVisible = false,
})
