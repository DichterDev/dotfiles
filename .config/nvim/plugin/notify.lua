require("mini.notify").setup({
	lsp_progress = { enable = false },
})

Autocmd("ColorScheme", "mini-notify-bg", {
	callback = function()
		RemoveBG({
			"MiniNotifyNormal",
			"MiniNotifyTitle",
			"MiniNotifyBorder",
		})
	end,
})

require("fidget").setup({
	notification = {
		window = {
			winblend = 0,
			relative = "editor",
		},
	},
	progress = {
		display = {
			render_limit = 16,
			done_ttl = 3,
		},
	},
})
