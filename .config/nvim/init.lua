vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.cmd.packadd("nvim.undotree")

vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { desc = "[u]ndotree" })

vim.cmd.packadd("nohlsearch")
