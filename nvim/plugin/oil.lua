require("oil").setup({
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			return name == ".." or name == ".git"
		end,
	},
	confirmation = {
		border = "rounded",
	},
	skip_confirm_for_simple_edits = true,
	keymaps = {
		["h"] = { "actions.parent", mode = "n" },
		["l"] = { "actions.select", mode = "n" },
		["<C-h>"] = {},
		["<C-j>"] = {},
		["<C-k>"] = {},
		["<C-l>"] = {},
		["<C-s>"] = {},
	},
})
