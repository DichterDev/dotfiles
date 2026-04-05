---@module "lazy"
---@type LazySpec
return {
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
	{
		"folke/lazydev.nvim",
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		ft = { "lua" },
		---@module "lazydev"
		---@type lazydev.Config
		opts = {
			library = {
				"lazy.nvim",
				{ path = vim.fn.stdpath("config") .. "/lua", words = { "config" } },
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
		config = function(_, opts)
			require("lazydev").setup(opts)
			local ok, lsp = pcall(require, "lazydev.lsp")
			if ok then
				table.insert(lsp.supported_clients, "lua")
			end
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			mode = "fuzzy",
			incremental = true,
			label = {
				rainbow = {
					enabled = true,
					shade = 4,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		---@module "noice"
		---@type NoiceConfig
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
				message = {
					enabled = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["blink.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "lsp",
					},
					opts = { skip = true },
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
	},
}
