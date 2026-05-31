local gh = require("util").pack.gh

vim.pack.add({
	{
		src = gh("saghen/blink.cmp"),
		version = vim.version.range("1.*"),
	},
	gh("neovim/nvim-lspconfig"),
	gh("rafamadriz/friendly-snippets"),
})

require("blink.cmp").setup({
	snippets = { preset = "mini_snippets" },
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	keymap = {
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = {
			function(cmp)
				return cmp.select_next()
			end,
			"snippet_forward",
			"fallback",
		},
		["<S-Tab>"] = {
			function(cmp)
				return cmp.select_prev()
			end,
			"snippet_backward",
			"fallback",
		},
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-up>"] = { "scroll_documentation_up", "fallback" },
		["<C-down>"] = { "scroll_documentation_down", "fallback" },
	},
	cmdline = {
		keymap = { preset = "inherit" },
		completion = {
			menu = { auto_show = true },
			list = { selection = { preselect = false, auto_insert = false } },
			ghost_text = { enabled = true },
		},
	},
	completion = {
		accept = { auto_brackets = { enabled = true } },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
			update_delay_ms = 50,
			treesitter_highlighting = true,
			window = {
				border = { " ", " ", " ", " ", " ", " ", " ", " " },
			},
		},
		list = { selection = { preselect = false, auto_insert = false } },
		ghost_text = { enabled = true },
	},
	signature = {
		enabled = true,
		window = {
			border = { " ", " ", " ", " ", " ", " ", " ", " " },
			treesitter_highlighting = true,
		},
	},
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer", "cmdline" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 1000,
			},
			lsp = { min_keyword_length = 0 },
			path = { min_keyword_length = 0 },
			snippets = { min_keyword_length = 2 },
			buffer = { min_keyword_length = 4, max_items = 5 },
			cmdline = { min_keyword_length = 0 },
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local remove_bg = require("util").hl.remove_bg
		remove_bg("BlinkCmpDoc")
		remove_bg("BlinkCmpSignatureHelp")
	end,
})
