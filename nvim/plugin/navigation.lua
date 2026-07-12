require("flash").setup({})

Map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end)

Map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end)

Map({ "n", "x", "o" }, "r", function()
	require("flash").remote()
end)

Map({ "n", "x", "o" }, "R", function()
	require("flash").treesitter_search()
end)

Map("c", "<C-s>", function()
	require("flash").toggle()
end)

require("aerial").setup({
	nerd_font = "auto",
	layout = {
		min_width = 0.2,
		max_width = 0.3,
		default_direction = "prefer_right",
	},
})

Map("n", "<leader>o", "<CMD>AerialToggle!<CR>", { desc = "toggle aerial [o]utline" })

require("overseer").setup({})
