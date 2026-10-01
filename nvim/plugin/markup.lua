require("typst-preview").setup({
	debug = true,
})

require("quarto").setup({})

require("render-markdown").setup({
	enabled = true,
	render_modes = { "n", "c" },

	anti_conceal = {
		enabled = false,
	},

	win_options = {
		conceallevel = {
			default = 2,
			rendered = 2,
		},
	},

	link = {
		enabled = true,
	},
})

Autocmd("ColorScheme", "render-markdown-colorscheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { bg = "NONE", update = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "NONE", update = true })
	end,
})
