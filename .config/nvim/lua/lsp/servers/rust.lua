---@type Server
local M = {}

M.config = {
	name = "rust_analyzer",
	cmd = { "rustup", "run", "nightly", "rust-analyzer" },
	capabilities = require("lsp.defaults").capabilities({}),
	filetypes = { "rust" },
	root_dir = vim.fs.root(0, { "Cargo.toml", "rust-project.json" }),
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
			},
			checkOnSave = true,
			procMacro = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				experimental = { enable = true },
			},
			inlayHints = {
				enable = true,
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

return M
