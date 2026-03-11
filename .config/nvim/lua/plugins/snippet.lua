---@type LazySpec
return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			ls.setup({
				delete_check_events = "InsertLeave",
			})

			require("luasnip.loaders.from_lua").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" },
			})

			require("luasnip.loaders.from_vscode").lazy_load()

			Map({ "i", "s" }, "<C-j>", function()
				if ls.expandable() then
					ls.expand()
				end
			end)
		end,
	},
}
