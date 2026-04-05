---@type LazySpec
return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("mini.statusline").setup({ use_icons = true })

			require("mini.tabline").setup({})

			require("mini.pairs").setup({})
			require("mini.ai").setup({})
			require("mini.surround").setup({})
			require("mini.move").setup({})
			require("mini.splitjoin").setup({})
			require("mini.notify").setup({
				window = { winblend = 0 },
				lsp_progress = { enable = false },
			})

			require("mini.icons").setup({})
			require("mini.trailspace").setup({})
			require("mini.align").setup({})
			require("mini.keymap").setup({})
			require("mini.bracketed").setup({})

			require("mini.animate").setup({
				scroll = { enable = false },
				resize = { enable = false },
				open = { enable = false },
				close = { enable = false },
			})

			local map_multistep = require("mini.keymap").map_multistep

			map_multistep("i", "<Tab>", { "pmenu_next" })
			map_multistep("i", "<S-Tab>", { "pmenu_prev" })
			map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
			map_multistep("i", "<BS>", { "minipairs_bs" })
		end,
	},
}
