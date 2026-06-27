require("mini.basics").setup({
	options = {
		win_borders = "rounded",
	},
	mappings = {
		windows = true,
	},
})

require("mini.extra").setup()
require("mini.icons").setup({
	lsp = {
		["function"] = { glyph = "󰊕", hl = "MiniIconsAzure" },
	},
})

local map_multistep = require("mini.keymap").map_multistep

map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })

require("scrollEOF").setup({})
