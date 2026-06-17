---@type vim.lsp.Config
return {
	---@type lspconfig.settings.rust_analyzer
	settings = {
		["rust-analyzer"] = {
			cargo = {},
			checkOnSave = true,
			diagnostics = {
				enable = true,
				experimental = { enable = true },
			},
			inlayHints = {
				bindingModeHints = { enable = true },
				closingBraceHints = { enable = true },
				closureReturnTypeHints = { enable = "always" },
				lifetimeElisionHints = { enable = "skip_trivial" },
				reborrowHints = { enable = "always" },
				typeHints = { enable = true },
				parameterHints = { enable = true },
				chainingHints = { enable = true },
			},
			lens = {
				debug = { enable = true },
				enable = true,
				implementations = { enable = true },
				references = {
					adt = { enable = true },
					enumVariant = { enable = true },
					method = { enable = true },
					trait = { enable = true },
				},
				run = { enable = true },
				updateTest = { enable = true },
			},
		},
	},
}
