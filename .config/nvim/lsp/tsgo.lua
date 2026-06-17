---@type vim.lsp.Config
return {
	settings = {
		tsgo = {
			typescript = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
					importModuleSpecifierEnding = "minimal",
				},
			},
			javascript = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
				},
			},
		},
	},
}
