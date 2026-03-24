---@type LazySpec
return {
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = { "nvim-mini/mini.icons" },
		lazy = false,
		---@type FylerSetup
		---@diagnostic disable: missing-fields
		opts = {
			integrations = {
				-- winpick = "builtin",
			},
			views = {
				finder = {
					default_explorer = true,
					follow_current_file = true,
					columns = {
						git = {
							enabled = true,
						},
					},
				},
			},
		},
		---@diagnostic disable: missing-fields
		keys = {
			{
				"<leader>x",
				mode = "n",
				function()
					require("fyler").toggle({ kind = "split_left" })
				end,
				desc = "Open File Manager",
			},
		},
	},
}
