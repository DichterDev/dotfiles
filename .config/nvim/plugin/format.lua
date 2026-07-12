---@module "conform"
---@type conform.setupOpts
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "oxfmt" },
		typescript = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		json = { "oxfmt" },
		jsonc = { "oxfmt" },
		vue = { "oxfmt" },
		markdown = { "oxfmt" },
		html = { "oxfmt" },
		css = { "oxfmt" },
		sql = { "sleek" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		async = false,
		timeout_ms = 500,
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
})
