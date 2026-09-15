require("neo-tree").setup({
	filesystem = {
		use_libuv_file_watcher = true,
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
	},
	window = {
		mappings = {
			["a"] = "none",
			["d"] = "none",
			["r"] = "none",
			["m"] = "none",
			["x"] = "none",
		},
	},
})

Autocmd("ColorScheme", "neo-tree-background", {
	callback = function()
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", update = true })
	end,
})
