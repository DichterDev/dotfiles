local gh = require("util").pack.gh

vim.pack.add({ gh("stevearc/conform.nvim") })

---@module "conform"
---@type conform.setupOpts
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		java = { "jdtls" },
		html = { "superhtml" },
		javascript = { "prettierd", "eslint_d" },
		typescript = { "prettierd", "eslint_d" },
		javascriptreact = { "prettierd", "eslint_d" },
		typescriptreact = { "prettierd", "eslint_d" },
		vue = { "prettierd", "eslint_d" },
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
})
