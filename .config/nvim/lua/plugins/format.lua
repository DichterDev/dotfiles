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
			groovy = { "indent_only" },
			just = { "just" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
		formatters = {
			indent_only = {
				format = function(_, ctx, _, cb)
					local view = vim.fn.winsaveview()
					vim.api.nvim_buf_call(ctx.buf, function()
						vim.cmd("normal! gg=G")
					end)
					vim.fn.winrestview(view)
					cb(nil)
				end,
			},
		},
	},
}
