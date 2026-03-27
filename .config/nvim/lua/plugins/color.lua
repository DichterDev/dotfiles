vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local function set_hl(name)
			vim.api.nvim_set_hl(0, name, { bg = "none" })
		end

		set_hl("NormalFloat")
		set_hl("FloatBorder")
		set_hl("FloatTitle")

		set_hl("BlinkCmpMenu")
		set_hl("BlinkCmpMenuBorder")
		set_hl("BlinkCmpDoc")
		set_hl("BlinkCmpDocBorder")

		set_hl("Pmenu")
		set_hl("PmenuSbar")
		set_hl("PmenuThumb")

		set_hl("TreesitterContext")

		set_hl("MiniMapNormal")
		set_hl("MiniFilesBorder")
		set_hl("MiniFilesNormal")
		set_hl("MiniFilesTitle")
	end,
})

---@type LazySpec
return {
	{
		"darianmorat/gruvdark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvdark").setup({
				transparent = true,
			})
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				background = {
					light = "latte",
					dark = "macchiato",
				},
				transparent_background = true,
				float = {
					transparent = true,
					solid = false,
				},
				integrations = {
					nvimtree = true,
					mini = true,
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				transparent = true,
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},
}
