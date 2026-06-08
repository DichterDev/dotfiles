require("quicker").setup()

Map("n", "<leader>q", require("quicker").toggle, { desc = "toggle [q]uickfix" })

Map("n", "<leader>l", function()
	require("quicker").toggle({ loclist = true })
end, {
	desc = "toggle [l]oclist",
})
