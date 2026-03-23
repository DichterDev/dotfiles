---@type LazySpec
return {
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = { "nvim-mini/mini.icons" },
		lazy = false,
		opts = {},
		keys = {
			{
				"<leader>x",
				mode = "n",
				function()
					require("fyler").open({ kind = "float" })
				end,
				desc = "Open File Manager",
			},
		},
	},
}
