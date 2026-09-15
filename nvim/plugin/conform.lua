---@module "conform"
---@type conform.setupOpts
require("conform").setup({
	formatters_by_ft = {
		css = { "oxfmt" },
		html = { "oxfmt" },
		javascript = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		json = { "oxfmt" },
		jsonc = { "oxfmt" },
		lua = { "stylua" },
		markdown = { "oxfmt" },
		nix = { "nixfmt" },
		rust = { "rustfmt" },
		sql = { "sleek" },
		typescript = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		typst = { "typstyle" },
		vue = { "oxfmt" },
		["_"] = { "indent_only" },
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
