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
		["<Up>"] = {},
		["<Down>"] = {},
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
		menu = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,Border:FloatBorder",
			max_height = 15,
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
			update_delay_ms = 50,
			treesitter_highlighting = true,
			window = {
				border = "rounded",
			},
		},
		list = { selection = { preselect = false, auto_insert = false } },
		ghost_text = { enabled = true },
	},
	signature = {
		enabled = true,
		window = {
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
