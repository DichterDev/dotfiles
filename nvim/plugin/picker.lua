PackAdd({
	"gh:ibhagwan/fzf-lua",
	"gh:stephansama/fzf-nerdfont.nvim",
})

---@diagnostic disable: missing-fields
local fzf = require("fzf-lua")
fzf.setup({
	file_ignore_patterns = {
		"node_modules/.*",
		"build/.*",
		"bin/.*",
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

Map("n", "<leader>F", "<CMD>FzfLua global<CR>", { desc = "[F]ind" })
Map("n", "<leader>ff", "<CMD>FzfLua files<CR>", { desc = "[f]ind [f]iles" })
Map("n", "<leader>fg", "<CMD>FzfLua git_files<CR>", { desc = "[f] [g]it files" })
Map("n", "<leader>fr", "<CMD>FzfLua live_grep resume=true<CR>", { desc = "[f]ind [r]ipgrep" })
Map("n", "<leader><Tab>", "<CMD>FzfLua buffers<CR>", { desc = "[f]ind [b]uffers" })
Map("n", "<leader>fo", "<CMD>FzfLua oldfiles<CR>", { desc = "[f]ind [o]ldfiles" })
Map("n", "<leader>fq", "<CMD>FzfLua quickfix<CR>", { desc = "[f]ind [q]ickfix" })
Map("n", "<leader>fh", "<CMD>FzfLua quickfix_stack", { desc = "[f]ind [h]istory" })
Map("n", "<leader>fk", "<CMD>FzfLua keymaps<CR>", { desc = "[f]ind [k]eymaps" })
Map("n", "<leader>fb", "<CMD>FzfLua blines<CR>", { desc = "[f]ind [b]uffer lines" })
Map("n", "<leader>ft", "<CMD>FzfLua tags_live_grep<CR>", { desc = "[f]ind [t]ags" })
Map("n", "<leader>fd", "<CMD>FzfLua lsp_workspace_diagnostics<CR>", { desc = "[f]ind [d]iagnostics" })
Map("n", "<leader>fx", "<CMD>FzfLua lsp_document_diagnostics<CR>", { desc = "[f]ind buffer diagnostics" })
Map("n", "<leader>fz", "<CMD>FzfLua zoxide<CR>", { desc = "[f]ind [z]oxide" })

Autocmd("LspAttach", "fzf-lua-lsp", {
	callback = function(args)
		local function opts(desc)
			return { desc = desc, noremap = true, silent = true, buffer = args.buf }
		end

		Map("n", "gd", "<CMD>FzfLua lsp_definitions<CR>", opts("[g]o [d]efinition"))
		Map("n", "gr", "<CMD>FzfLua lsp_references<CR>", opts("[g]o [r]efrences"))
		Map("n", "gD", "<CMD>FzfLua lsp_declarations<CR>", opts("[g]o [D]eclaration"))
		Map("n", "gi", "<CMD>FzfLua lsp_implementations<CR>", opts("[g]o [i]mplementation"))
		Map("n", "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", opts("[c]ode [a]ctions"))

		Map("n", "<leader>rn", vim.lsp.buf.rename, opts("[r]e[n]ame"))

		Map("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded", max_width = 120, max_height = 40 })
		end, opts("Hover Documentation"))

		Map(
			"n",
			"<leader>fF",
			"<CMD>FzfLua lsp_document_symbols query=Function\\ |\\ Method<CR>",
			opts("[f]ind [F]unctions")
		)
	end,
})

Autocmd("PackChanged", "fzf-nerdfont-update", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if name == "fzf-nerdfont" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("fzf-nerdfont")
			end
			vim.cmd("FzfNerdfont generate")
		end
	end,
})

require("fzf-nerdfont").setup({})

Map("n", "<leader>fi", "<CMD>FzfNerdfont<CR>", { desc = "[f]ind [i]con" })
