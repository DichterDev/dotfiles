vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local remove_bg = require("util").hl.remove_bg
		remove_bg("Normal")
		-- remove_bg("NormalFloat")
		remove_bg("FloatBorder")
		remove_bg("FloatTitle")
	end,
})
