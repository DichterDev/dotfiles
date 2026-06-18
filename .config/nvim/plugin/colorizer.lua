require("colorizer").setup({
	options = {
		parsers = {
			css = true,
			css_fn = true,
			tailwind = {
				enable = true,
				update_names = true,
				lsp = {
					enable = true,
					disable_document_color = false,
				},
			},
		},
		display = {
			---@type "foreground" | "background" | "underline" | "virtualtext"
			mode = "foreground",
			virtualtext = {
				char = "",
				position = "before",
				hl_mode = "foreground",
			},
		},
	},
})
