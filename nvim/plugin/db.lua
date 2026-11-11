vim.g.db_ui_use_nerd_fonts = 1

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		vim.bo.omnifunc = "vim_dadbod_completion#omni"
	end,
})

Autocmd("ColorScheme", "dbui-remove-bg", {
	callback = function()
		local set_hl = vim.api.nvim_set_hl

		set_hl(0, "NotificationInfo", { bg = "NONE", update = true })
		set_hl(0, "NotificationWarning", { bg = "NONE", update = true })
		set_hl(0, "NotificationError", { bg = "NONE", update = true })
	end,
})
