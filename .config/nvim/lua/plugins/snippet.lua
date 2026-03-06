---@type LazySpec
return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			require("luasnip.loaders.from_lua").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" },
			})

			Map({ "i", "s" }, "<C-j>", function()
				if ls.expandable() then
					ls.expand()
				end
			end)
		end,
	},
}
