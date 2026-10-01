require("gitsigns").setup({})

Autocmd("ColorScheme", "gitsigns-remove-bg", {
	callback = function()
		for _, hl in ipairs({ "Add", "Change", "Delete" }) do
			vim.api.nvim_set_hl(0, "GitSigns" .. hl, { bg = "NONE", update = true })
		end
	end,
})
