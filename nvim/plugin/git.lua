PackAdd({
	"gh:lewis6991/gitsigns.nvim",
	-- NEOGIT
	"gh:sindrets/diffview.nvim",
	"gh:NeogitOrg/neogit",
})

require("gitsigns").setup({})

Map({ "n" }, "<leader>gg", "<CMD>Neogit<CR>", { desc = "Show Neogit UI" })
