require("mini.notify").setup({
	lsp_progress = { enable = false },
})

RemoveBG({
	"MiniNotifyNormal",
	"MiniNotifyTitle",
	"MiniNotifyBorder",
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
