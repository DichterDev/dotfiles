PackAdd("gh:nvim-mini/mini.nvim")

require("mini.ai").setup()
require("mini.move").setup()
require("mini.align").setup()
require("mini.extra").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.bracketed").setup()
require("mini.splitjoin").setup()

require("mini.basics").setup({
	options = {
		win_borders = "rounded",
	},
	mappings = {
		windows = true,
	},
})

require("mini.icons").setup({
	lsp = {
		["function"] = { glyph = "󰊕", hl = "MiniIconsAzure" },
	},
})

require("mini.tabline").setup({
	format = function(buf_id, label)
		local suffix = vim.bo[buf_id].modified and "+ " or ""
		return MiniTabline.default_format(buf_id, label) .. suffix
	end,
})

vim.o.laststatus = 3

require("mini.statusline").setup({
	use_icons = true,
})

require("mini.animate").setup({
	scroll = { enable = false },
	resize = { enable = false },
	open = { enable = false },
	close = { enable = false },
})

require("mini.snippets").setup({
	snippets = {
		require("mini.snippets").gen_loader.from_lang(),
	},
})

local map_multistep = require("mini.keymap").map_multistep

map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })
