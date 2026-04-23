local gh = require("util").pack.gh

vim.pack.add({ gh("nvim-mini/mini.nvim") })

vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,folds,terminal"

require("mini.sessions").setup({
	autowrite = true,
	directory = vim.fn.stdpath("data") .. "/session",
})

vim.keymap.set("n", "<leader>fs", MiniSessions.select, { desc = "[f]ind [s]ession" })
