require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {
			config = {
				icon_preset = "diamond",
			},
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				},
				default_workspace = "notes",
			},
		},
	},
})
