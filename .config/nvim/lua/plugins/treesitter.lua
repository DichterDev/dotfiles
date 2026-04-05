---@class Parser : ParserInfo
---@field name string

---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			ts.install("all")

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					local ft = vim.filetype.match({ buf = args.buf })
					if not ft then
						return
					end

					local ok, _ = pcall(vim.treesitter.get_parser, args.buf, ft)
					if ok then
						vim.treesitter.start()
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		---@module "treesitter-context"
	},
}
