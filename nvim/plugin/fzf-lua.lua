---@diagnostic disable: missing-fields
local fzf = require("fzf-lua")
fzf.setup({
	file_ignore_patterns = {
		"node_modules/.*",
		"build/.*",
		-- "bin/.*",
		"target/.*",
		".next/*",
	},
	fzf_opts = {
		["--cycle"] = true,
	},
	keymap = {
		fzf = {
			["tab"] = "down",
			["shift-tab"] = "up",

			["alt-j"] = "toggle+down",
			["alt-n"] = "toggle+down",
			["alt-down"] = "toggle+down",
			["alt-k"] = "toggle+up",
			["alt-p"] = "toggle+up",
			["alt-up"] = "toggle+up",
		},
	},
	grep = {
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden",
	},
	hls = {
		title = "FloatTitle",
		border = "FloatBorder",
		preview_title = "FloatTitle",
		preview_border = "FloatBorder",
	},
})

fzf.register_ui_select()
