local gh = require("util").pack.gh

vim.pack.add({ gh("hedyhli/outline.nvim") })

require("outline").setup({})

vim.keymap.set("n", "<leader>o", ":Outline<CR>", { desc = "toggle [o]utline" })
