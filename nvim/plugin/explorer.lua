require("oil").setup({
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			return name == ".." or name == ".git"
		end,
	},
	keymaps = {
		["h"] = { "actions.parent", mode = "n" },
		["l"] = { "actions.select", mode = "n" },
		["<C-h>"] = {},
		["<C-j>"] = {},
		["<C-k>"] = {},
		["<C-l>"] = {},
	},
})

Map("n", "<leader>x", ":Oil<CR>", { desc = "e[x]plore" })
Map("n", "<leader>X", function()
	require("oil").open(vim.fn.getcwd())
end, { desc = "e[X]plore cwd" })

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

Map("n", "<leader>e", ":Neotree toggle show right<CR>", { desc = "toggle neotree" })
