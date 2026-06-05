local gh = require("util").pack.gh

vim.pack.add({ gh("stevearc/quicker.nvim") })

require("quicker").setup()

vim.keymap.set("n", "<leader>q", require("quicker").toggle, { desc = "toggle [q]uickfix" })

vim.keymap.set("n", "<leader>l", function()
	require("quicker").toggle({ loclist = true })
end, {
	desc = "toggle [l]oclist",
})
