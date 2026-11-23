require("neo-tree").setup({
	filesystem = {
		use_libuv_file_watcher = true,
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
	},
	window = {
		position = "right",
		mappings = {
			["a"] = "none",
			["d"] = "none",
			["r"] = "none",
			["m"] = "none",
			["x"] = "none",
		},
	},
	add_blank_line_at_top = true,
})

Autocmd("ColorScheme", "neo-tree-background", {
	callback = function()
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", update = true })
	end,
})
