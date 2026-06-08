local lensline = require("lensline")

lensline.setup({
	profiles = {
		{
			name = "basic",
			providers = {
				{
					name = "usages",
					enabled = true,
					include = { "refs", "defs", "impls" },
					labels = {
						refs = "",
						defs = "",
						impls = "",
					},
					breakdown = true,
					show_zero = true,
					inner_separator = "  ",
				},
			},
			style = {
				prefix = "▎",
				separator = "  ",
				placement = "above",
				use_nerdfont = true,
				render = "all",
				highlight = "LspCodeLens",
			},
		},
		{
			name = "inline_simple",
			providers = {
				{
					name = "usages",
					enabled = true,
					include = { "refs", "defs", "impls" },
					labels = {
						refs = "",
						defs = "",
						impls = "",
					},
					breakdown = false,
					show_zero = true,
					inner_separator = "  ",
				},
			},
			style = {
				prefix = " ",
				separator = "  ",
				placement = "inline",
				use_nerdfont = true,
				render = "all",
				highlight = "LspCodeLens",
			},
		},
		{
			name = "inline",
			providers = {
				{
					name = "usages",
					enabled = true,
					include = { "refs", "defs", "impls" },
					labels = {
						refs = "",
						defs = "",
						impls = "",
					},
					breakdown = true,
					show_zero = true,
					inner_separator = "  ",
				},
			},
			style = {
				prefix = " ",
				separator = "  ",
				placement = "inline",
				use_nerdfont = true,
				render = "all",
				highlight = "LspCodeLens",
			},
		},
	},
})

lensline.switch_profile("inline_simple")
