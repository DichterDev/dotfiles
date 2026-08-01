PackAdd({
	"gh:jmbuhr/otter.nvim",
	"gh:quarto-dev/quarto-nvim",
	"gh:hakonharnes/img-clip.nvim",
	"gh:chomosuke/typst-preview.nvim",
	"gh:MeanderingProgrammer/render-markdown.nvim",
})

require("typst-preview").setup({})

require("quarto").setup({})

require("render-markdown").setup({
	render_modes = { "n", "v", "c", "t" },

	anti_conceal = {
		enabled = false,
	},

	win_options = {
		conceallevel = {
			default = 2,
			rendered = 2,
		},
		concealcursor = {
			default = "nvi",
			rendered = "nvi",
		},
	},
})

Autocmd("ColorScheme", "render-markdown-colorscheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { bg = "NONE", update = true })
	end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
	pattern = "markdown",
	callback = function()
		if vim.bo.readonly or not vim.bo.modifiable then
			require("render-markdown").setup({ anti_conceal = { enabled = false } })
		else
			require("render-markdown").setup({ anti_conceal = { enabled = true } })
		end
	end,
})
