PackAdd("gh:nvim-mini/mini.nvim")

require("mini.ai").setup()
require("mini.align").setup()
require("mini.bracketed").setup()
require("mini.cursorword").setup()
require("mini.extra").setup()
require("mini.move").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.indentscope").setup()

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
	filetype = {
		["env"] = { glyph = "", hl = "MiniIconsOrange" },
	},
})

require("mini.tabline").setup({
	format = function(buf_id, label)
		local suffix = vim.bo[buf_id].modified and "+ " or ""
		return MiniTabline.default_format(buf_id, label) .. suffix
	end,
})

require("mini.statuscolumn").setup({
	content = require("mini.statuscolumn").gen_content.main({
		-- `f` (fold), `s` (sign), `l` (lnum), and `=` (as `%=` in |'statusline'| syntax)
		{ format = "fl=s", sep = "▏" },
		{ ltype = "virt", lnum = "•" },
		{ ltype = "wrap", lnum = "↳" },
		{ win = "inactive", fold = "", lnum = "", sign = "" },
	}),
})

vim.o.laststatus = 3

require("mini.statusline").setup({
	use_icons = true,
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
				"%<", -- Mark general truncate point
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { search, location } },
			})
		end,
	},
})

require("mini.notify").setup({
	lsp_progress = { enable = false },
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
