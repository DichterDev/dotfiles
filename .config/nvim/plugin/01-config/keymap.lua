-- Normal Mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Remaps
vim.keymap.set({ "n", "x", "o" }, "ö", "[", { desc = "Left bracket [", remap = true })
vim.keymap.set({ "n", "x", "o" }, "ä", "]", { desc = "Right bracket ]", remap = true })
vim.keymap.set({ "n", "x", "o" }, "ü", "\\", { desc = "Backslash \\", remap = true })

-- Select all
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Visual select all" })

-- Quit
vim.keymap.set("n", "<leader>Q", ":qa<CR>", { desc = "[Q]it all" })

-- Incremental Selection
-- src: https://www.reddit.com/r/neovim/comments/1scauyd/comment/oecobq8/
vim.keymap.set({ "x", "o" }, "v", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_parent(vim.v.count1)
	else
		vim.lsp.buf.selection_range(vim.v.count1)
	end
end)

vim.keymap.set({ "x", "o" }, "V", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_child(vim.v.count1)
	else
		vim.lsp.buf.selection_range(-vim.v.count1)
	end
end)

-- Split windows
vim.keymap.set("n", "<leader>vs", "<CMD>vsplit<CR>", { desc = "[v]ertical [s]plit" })
vim.keymap.set("n", "<leader>hs", "<CMD>:hsplit", { desc = "[h]orizontal [s]plit" })

-- Yanking
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "[yy]ank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y_', { desc = "[Y]ank to clipboard" })

-- Pasting
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "[p]aste from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P"', { desc = "[P]aste from clipboard" })
