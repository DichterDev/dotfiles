require("typst-preview").setup({
	debug = true,
})

require("quarto").setup({})

require("render-markdown").setup({
	render_modes = { "n" },

	code = {
		conceal_delimiters = true,
		border = "thin",
		language_icon = false,
	},
})

Autocmd("ColorScheme", "render-markdown-colorscheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { bg = "NONE", update = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "NONE", update = true })
	end,
})
