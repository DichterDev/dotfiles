---@type LazySpec
return {
	{
		"chomosuke/typst-preview.nvim",
		ft = { "typst" },
		version = "1.*",
		---@module "typst-preview"
		opts = {
			get_root = function(path)
				return vim.fs.dirname(vim.fs.find({ ".git", ".root", "typst.toml" }, { upward = true, path = path })[1])
			end,
		},
	},
}
