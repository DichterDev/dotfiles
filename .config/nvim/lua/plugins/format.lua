---@type LazySpec
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufNewFile" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			html = { "superhtml" },
			css = { "oxfmt" },
			go = { "goimports", "gofumpt" },
			javascript = { "oxlint", "oxfmt" },
			typescript = { "oxlint", "oxfmt" },
			vue = { "oxlint", "oxfmt" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
		formatters = {},
	},
}
