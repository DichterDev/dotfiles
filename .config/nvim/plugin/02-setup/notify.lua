local gh = require("util").pack.gh

vim.pack.add({ gh("nvim-mini/mini.nvim") })

require("mini.notify").setup({
	lsp_progress = { enable = false },
})

vim.api.nvim_set_hl(0, "MiniNotifyNormal", { bg = "none", update = true })
vim.api.nvim_set_hl(0, "MiniNotifyBorder", { bg = "none", update = true })
vim.api.nvim_set_hl(0, "MiniNotifyTitle", { bg = "none", update = true })

vim.pack.add({ gh("j-hui/fidget.nvim") })

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
