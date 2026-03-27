---@type LazySpec
return {
	{
		"stephansama/fzf-nerdfont.nvim",
		lazy = true,
		build = ":FzfNerdfont generate",
		dependencies = { "ibhagwan/fzf-lua" },
		cmd = "FzfNerdfont",
		keys = {
			{ "<leader>fi", "<CMD>FzfNerdfont<CR>", desc = "[f]ind [i]con" },
		},
		---@module 'fzf-nerdfont'
		---@type FzfNerdFontOpts
		opts = {},
	},
}
