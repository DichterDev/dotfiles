local util = require("util")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.cmd.packadd("nvim.undotree")

vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { desc = "[u]ndotree" })

vim.cmd.packadd("nohlsearch")

Gh = util.pack.gh
Autocmd = util.autocmd.autocmd
RemoveBG = util.hl.remove_bg
LspSetup = util.lsp.setup
Map = util.keymap.set
