---@type LazySpec
return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-mini/mini.icons", "nvim-tree/nvim-web-devicons" },
		---@module "oil"
		---@type oil.SetupOpts
		opts = {
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git"
				end,
			},
			float = {
				padding = 2,
				max_width = 90,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			preview_win = {
				update_on_cursor_moved = true,
			},
			skip_confirm_for_simple_edits = true,
		},
		config = function(_, opts)
			local oil = require("oil")
			oil.setup(opts)

			Map("n", "<leader>x", function()
				oil.open(nil, { preview = { vertical = true } })
			end, { desc = "Explorer" })
		end,
	},
}
