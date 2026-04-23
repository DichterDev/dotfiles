vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		for _, name in ipairs({ "Hint", "Info", "Warn", "Error" }) do
			vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. name, {
				underline = true,
				undercurl = false,
				update = true,
			})
		end
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})
