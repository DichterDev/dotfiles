local util = require("util")

Autocmd = util.cmd.autocmd
Usercmd = util.cmd.usercmd

--#region GLOBALS

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.editorconfig = true
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

--#endregion

--#region ENV

vim.env.JAVA_HOME = "/usr/lib/jvm/default"
vim.env.JDK17 = "/usr/lib/jvm/java-17-openjdk/"
vim.env.JDK21 = "/usr/lib/jvm/java-21-openjdk/"
vim.env.JDK25 = "/usr/lib/jvm/java-25-openjdk/"
vim.env.JDK26 = "/usr/lib/jvm/java-26-openjdk/"

--#endregion

--#region OPTIONS

local opt = vim.o

opt.exrc = true

opt.wrap = false
opt.linebreak = true
opt.breakindent = true
-- opt.showbreak = "↳"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.number = true
opt.cursorline = true

opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"

opt.fillchars = "eob: ,fold: ,foldopen:󰅀,foldsep: ,foldinner: ,foldclose:"

opt.list = false
opt.listchars = "trail:·,tab:»·,nbsp:+"

opt.scrolloff = 12
opt.sidescrolloff = 8
opt.undofile = true

opt.swapfile = false

opt.updatetime = 300
opt.timeoutlen = 500
opt.conceallevel = 0
opt.wildmode = "longest:full,full"
opt.virtualedit = "block"

opt.sh = "/bin/fish"
opt.background = "dark"
opt.termguicolors = true

opt.winblend = 0
opt.pumblend = 0

--#endregion

--#region DIAGNOSTIC

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})

--#endregion

--#region FILETYPES

local ft = vim.filetype

ft.add({
	extension = {
		launch = "xml",
	},
})

ft.add({
	extension = {
		srv = "conf",
		msg = "conf",
	},
})

--#endregion

--#region LSP

vim.lsp.inlay_hint.enable(true)

Usercmd("Lsp", function(opts)
	local subcommand = opts.fargs[1]

	if subcommand == "log" then
		local log_path = vim.fn.stdpath("log") .. "/lsp.log"
		vim.cmd("edit " .. vim.fn.fnameescape(log_path))
	elseif subcommand == "health" then
		vim.cmd("checkhealth vim.lsp")
	end
end, {
	nargs = "?",
	desc = "LSP helper commands",
	complete = function(arg_lead, cmd_line, cursor_pos)
		local subcommands = { "log", "health" }
		return vim.tbl_filter(function(item)
			return item:find("^" .. arg_lead)
		end, subcommands)
	end,
})

--#endregion

--#region AUTOCMD

Autocmd("ColorScheme", "transparent-bg", {
	callback = function()
		local set_hl = vim.api.nvim_set_hl

		local hls = vim.api.nvim_get_hl(0, { link = true })

		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })

		for name, hl in pairs(hls) do
			if hl.link == "Normal" then
				if not hl.bg then
					set_hl(0, name, { bg = normal.bg, link = "", update = true })
				end
			end
		end

		local keyword_fg = util.hl.get_prop("Keyword", "fg")
		local comment_fg = util.hl.get_prop("Comment", "fg")
		local const_fg = util.hl.get_prop("Constant", "fg")

		set_hl(0, "LspInlayHint", { fg = comment_fg, update = true })
		set_hl(0, "FloatTitle", { fg = keyword_fg, bg = normal.bg, update = true })
		set_hl(0, "FloatBorder", { fg = keyword_fg, bg = normal.bg, update = true })
		set_hl(0, "NormalFloat", { bg = normal.bg, update = true })
		set_hl(0, "CursorLineNr", { fg = const_fg, update = true })

		local NO_BG = {
			"Normal",
			"NormalNC",
			"Folded",
			"FoldColumn",
			"SignColumn",
			"TablineFill",
			"CursorLineNr",
		}

		for _, hl in ipairs(NO_BG) do
			set_hl(0, hl, { bg = "NONE", update = true })
		end
	end,
})

Autocmd("ColorScheme", "diagnostic-underline", {
	callback = function()
		for _, name in ipairs({ "Hint", "Info", "Warn", "Error" }) do
			vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. name, {
				underline = true,
				undercurl = false,
				update = true,
			})
		end
	end,
})

--#endregion

--#region CODELENS
-- vim.lsp.codelens.enable(true)
--
-- vim.lsp.handlers["textDocument/codeLens"] = function(err, result, ctx, _)
-- 	if err or not result then
-- 		return
-- 	end
-- 	local bufnr = ctx.bufnr
-- 	local ns = vim.api.nvim_create_namespace("lsp_codelens")
-- 	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
--
-- 	for _, lens in ipairs(result) do
-- 		local line = lens.range.start.line
-- 		local title = lens.command and lens.command.title or ""
--
-- 		if title ~= "" then
-- 			vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
-- 				virt_text = { { "  󰌹 " .. title, "LspCodeLens" } },
-- 				virt_text_pos = "eol",
-- 			})
-- 		end
-- 	end
-- end

--#endregion

--#region ROCKS
-- local rocks_location = vim.fn.stdpath("data") .. "/rocks"
-- local rocks_path = rocks_location .. "/share/lua/5.1/?.lua;" .. rocks_location .. "/share/lua/5.1/?/init.lua"
-- local rocks_cpath = rocks_location .. "/lib/lua/5.1/?.so"
--
-- package.path = package.path .. ";" .. rocks_path
-- package.cpath = package.cpath .. ";" .. rocks_cpath
--
-- local install_location = vim.fn.stdpath("data") .. "/site/pack/rocks/start/rocks.nvim"
--
-- if not vim.uv.fs_stat(install_location) then
-- 	print("Bootstrapping rocks.nvim...")
-- 	vim.fn.system({
-- 		"git",
-- 		"clone",
-- 		"--depth=1",
-- 		"https://github.com/nvim-neorocks/rocks.nvim.git",
-- 		install_location,
-- 	})
-- 	vim.cmd("packadd rocks.nvim")
--
-- 	vim.api.nvim_create_autocmd("User", {
-- 		pattern = "RocksSetupFinished",
-- 		callback = function()
-- 			vim.cmd("Rocks sync")
-- 		end,
-- 	})
-- end
--#endregion

--#region PLUGINS

vim.cmd.packadd("nvim.undotree")

vim.cmd.packadd("nohlsearch")

local packadd = require("core.pack").add

packadd("Colorschemes", {
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/darianmorat/gruvdark.nvim",
	"https://github.com/catppuccin/nvim",
	"https://github.com/pankvitek/bonbon.nvim",
	"https://github.com/navarasu/onedark.nvim",
	"https://github.com/scottmckendry/cyberdream.nvim",
	"https://github.com/sainnhe/sonokai",
	"https://github.com/jpwol/thorn.nvim",
})

packadd("Plugins", {
	"https://github.com/nvim-mini/mini.nvim",
	"https://codeberg.org/cryptomilk/nvim-pack-ui",

	"https://github.com/monaqa/dial.nvim",

	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/Aasim-A/scrollEOF.nvim",
	"https://github.com/HiPhish/rainbow-delimiters.nvim",
	"https://github.com/catgoose/nvim-colorizer.lua",
	"https://github.com/chrisgrieser/nvim-spider",
	"https://gitlab.com/itaranto/id3.nvim",

	-- MASON

	-- STEVEARC
	"https://github.com/stevearc/aerial.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/quicker.nvim",
	"https://github.com/stevearc/overseer.nvim",

	-- FOLKE
	"https://github.com/folke/flash.nvim",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/folke/todo-comments.nvim",

	"https://github.com/rachartier/tiny-cmdline.nvim",
	"https://github.com/rachartier/tiny-glimmer.nvim",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",

	{ spec = "https://github.com/kevinhwang91/nvim-ufo", deps = { "https://github.com/kevinhwang91/promise-async" } },

	["git"] = {
		"https://github.com/lewis6991/gitsigns.nvim",
		{ spec = "https://github.com/NeogitOrg/neogit", deps = { "https://github.com/sindrets/diffview.nvim" } },
	},

	["notify"] = {
		{ spec = "https://github.com/Bilal2453/luvit-meta", deps = { "https://github.com/j-hui/fidget.nvim" } },
	},

	["treesitter"] = {
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/nvim-treesitter/nvim-treesitter-context",
		"https://github.com/windwp/nvim-ts-autotag",
	},

	["lsp"] = {
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/mason-org/mason.nvim",
		"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		{ spec = { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } },
		"https://github.com/nanotee/sqls.nvim",
		"https://github.com/seblyng/roslyn.nvim",
		"https://github.com/mfussenegger/nvim-jdtls",
		-- "https://github.com/idelice/nvim-jls",
	},

	["explorer"] = {
		"https://github.com/stevearc/oil.nvim",
		{
			spec = { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
			deps = { "https://github.com/nvim-lua/plenary.nvim", "https://github.com/MunifTanjim/nui.nvim" },
		},
	},

	["dap"] = {
		"https://github.com/mfussenegger/nvim-dap",
		"https://github.com/mfussenegger/nvim-dap-python",
		"https://github.com/igorlfs/nvim-dap-view",
		"https://github.com/theHamsta/nvim-dap-virtual-text",
	},

	["picker"] = {
		"https://github.com/ibhagwan/fzf-lua",
		"https://github.com/stephansama/fzf-nerdfont.nvim",
	},

	["markup"] = {
		"https://github.com/jmbuhr/otter.nvim",
		"https://github.com/quarto-dev/quarto-nvim",
		"https://github.com/hakonharnes/img-clip.nvim",
		"https://github.com/chomosuke/typst-preview.nvim",
		"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	},

	["db"] = {
		"https://github.com/tpope/vim-dadbod",
		"https://github.com/kristijanhusak/vim-dadbod-ui",
		"https://github.com/kristijanhusak/vim-dadbod-completion",
	},
})

--#endregion

--#region KEYMAPS

local keymap = require("core.keymap")

keymap.setup({ opts = { silent = true } })

map = keymap.set
local multi = keymap.multi
local combo = keymap.combo

map("n", "<leader>u", ":Undotree<CR>", { desc = "[u]ndotree" })

map({ "n", "x", "o" }, "ö", "[", { desc = "Left bracket [", remap = true })
map({ "n", "x", "o" }, "ä", "]", { desc = "Right bracket ]", remap = true })
map({ "n", "x", "o" }, "ü", "\\", { desc = "Backslash \\", remap = true })
map("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
map({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

map("n", "<leader>a", "ggVG", { desc = "Visual select all" })

map("n", "<leader>Q", ":qa<CR>", { desc = "[Q]it all" })

-- src: https://www.reddit.com/r/neovim/comments/1scauyd/comment/oecobq8/
map({ "x", "o" }, "v", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_parent(vim.v.count1)
	else
		vim.lsp.buf.selection_range(vim.v.count1)
	end
end, { desc = "[v]isual increment" })

map({ "x", "o" }, "V", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_child(vim.v.count1)
	else
		vim.lsp.buf.selection_range(-vim.v.count1)
	end
end, { desc = "[V]isual decrement" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "[yy]ank to clipboard" })
map("n", "<leader>Y", '"+y_', { desc = "[Y]ank to clipboard" })

map({ "n", "v" }, "<leader>p", '"+p', { desc = "[p]aste from clipboard" })
map({ "n", "v" }, "<leader>P", '"+P"', { desc = "[P]aste from clipboard" })

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "[d]iagnostic float" })

combo("i", "jk", "<BS><BS><ESC>")
combo("i", "kj", "<BS><BS><ESC>")
combo("t", "jk", "<BS><BS><C-\\><C-n>")
combo("t", "kj", "<BS><BS><C-\\><C-n>")

local mode = { "i", "c" }

multi(mode, "<Tab>", {
	"blink_next",
	"minisnippets_next",
	"increase_indent",
	"jump_after_close",
})

multi(mode, "<S-Tab>", {
	"blink_prev",
	"minisnippets_prev",
	"decrease_indent",
	"jump_before_open",
})

multi(mode, "<CR>", {
	"blink_accept",
	"minipairs_cr",
})

multi("i", "<BS>", {
	"minipairs_bs",
	"hungry_bs",
})

multi(mode, "<C-n>", {
	"blink_next",
})

multi(mode, "<C-p>", {
	"blink_prev",
})

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

combo({ "n", "x" }, "gl", "g$")
combo({ "n", "x" }, "gh", "g^")

combo({ "n", "i", "x", "c" }, "<Esc><Esc>", function()
	vim.cmd("nohlsearch")
end)

map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end)

map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end)

map({ "n", "x", "o" }, "r", function()
	require("flash").remote()
end)

map({ "n", "x", "o" }, "R", function()
	require("flash").treesitter_search()
end)

map("c", "<C-s>", function()
	require("flash").toggle()
end)

map("n", "<leader>x", ":Oil<CR>", { desc = "e[x]plore" })
map("n", "<leader>X", function()
	require("oil").open(vim.fn.getcwd())
end, { desc = "e[X]plore cwd" })

map("n", "<leader>E", "<CMD>Neotree toggle show right<CR>", { desc = "toggle neotree" })

map("n", "<leader>o", "<CMD>AerialToggle!<CR>", { desc = "toggle aerial [o]utline" })
map({ "n" }, "<leader>gg", "<CMD>Neogit<CR>", { desc = "Show Neogit UI" })

--#region
map("n", "<leader>F", "<CMD>FzfLua global<CR>", { desc = "[F]ind" })
map("n", "<leader>ff", "<CMD>FzfLua files<CR>", { desc = "[f]ind [f]iles" })
map("n", "<leader>fg", "<CMD>FzfLua git_files<CR>", { desc = "[f] [g]it files" })
map("n", "<leader>fr", "<CMD>FzfLua live_grep resume=true<CR>", { desc = "[f]ind [r]ipgrep" })
map("n", "<leader><Tab>", "<CMD>FzfLua buffers<CR>", { desc = "[f]ind [b]uffers" })
map("n", "<leader>fo", "<CMD>FzfLua oldfiles<CR>", { desc = "[f]ind [o]ldfiles" })
map("n", "<leader>fq", "<CMD>FzfLua quickfix<CR>", { desc = "[f]ind [q]ickfix" })
map("n", "<leader>fh", "<CMD>FzfLua highlights<CR>", { desc = "[f]ind [h]istory" })
map("n", "<leader>fk", "<CMD>FzfLua keymaps<CR>", { desc = "[f]ind [k]eymaps" })
map("n", "<leader>fb", "<CMD>FzfLua blines<CR>", { desc = "[f]ind [b]uffer lines" })
map("n", "<leader>ft", "<CMD>FzfLua tags_live_grep<CR>", { desc = "[f]ind [t]ags" })
map("n", "<leader>fd", "<CMD>FzfLua lsp_workspace_diagnostics<CR>", { desc = "[f]ind [d]iagnostics" })
map("n", "<leader>fx", "<CMD>FzfLua lsp_document_diagnostics<CR>", { desc = "[f]ind buffer diagnostics" })
map("n", "<leader>fz", "<CMD>FzfLua zoxide<CR>", { desc = "[f]ind [z]oxide" })
map("n", "<leader>fi", "<CMD>FzfNerdfont<CR>", { desc = "[f]ind [i]con" })
map("n", "<leader>fs", require("mini.sessions").select, { desc = "[f]ind [s]ession" })
--#endregion

Autocmd("LspAttach", "fzf-lua-lsp", {
	callback = function(args)
		local function opts(desc)
			return { desc = desc, noremap = true, silent = true, buffer = args.buf }
		end

		map("n", "gd", "<CMD>FzfLua lsp_definitions<CR>", opts("[g]o [d]efinition"))
		map("n", "gr", "<CMD>FzfLua lsp_references<CR>", opts("[g]o [r]efrences"))
		map("n", "gD", "<CMD>FzfLua lsp_declarations<CR>", opts("[g]o [D]eclaration"))
		map("n", "gi", "<CMD>FzfLua lsp_implementations<CR>", opts("[g]o [i]mplementation"))
		map("n", "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", opts("[c]ode [a]ctions"))

		map("n", "<leader>rn", vim.lsp.buf.rename, opts("[r]e[n]ame"))

		map("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded", max_width = 120, max_height = 40 })
		end, opts("Hover Documentation"))
	end,
})

map("n", "<leader>q", require("quicker").toggle, { desc = "toggle [q]uickfix" })

map("n", "<leader>l", function()
	require("quicker").toggle({ loclist = true })
end, {
	desc = "toggle [l]oclist",
})

local has_dap, dap = pcall(require, "dap")
local has_dap_view, dap_view = pcall(require, "dap-view")

if has_dap then
	local function set_debug_keymaps()
		map("n", "<Down>", function()
			dap.step_over()
		end, { desc = "Debug: Step Over" })
		map("n", "<Right>", function()
			dap.step_into()
		end, { desc = "Debug: Step Into" })
		map("n", "<Left>", function()
			dap.step_out()
		end, { desc = "Debug: Step Out" })
		map("n", "<Up>", function()
			dap.restart_frame()
		end, { desc = "Debug: Restart Frame" })
	end

	local function remove_debug_keymaps()
		local arrow_keys = { "<Down>", "<Right>", "<Left>", "<Up>" }
		for _, key in ipairs(arrow_keys) do
			pcall(vim.keymap.del, "n", key)
		end
	end

	dap.listeners.after.event_initialized["dap_arrow_keymaps"] = function()
		set_debug_keymaps()
	end

	dap.listeners.before.event_terminated["dap_arrow_keymaps"] = function()
		remove_debug_keymaps()
	end

	dap.listeners.before.event_exited["dap_arrow_keymaps"] = function()
		remove_debug_keymaps()
	end

	map("n", "<F5>", function()
		dap.continue()
	end, { desc = "Debug: Start / Continue" })

	map("n", "<S-F5>", function()
		dap.terminate()
	end, { desc = "Debug: Stop / Terminate" })

	map("n", "<C-S-F5>", function()
		dap.restart()
	end, { desc = "Debug: Restart Session" })

	map("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Debug: Toggle [B]reakpoint" })
	map("n", "<leader>dB", function()
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, { desc = "Debug: Set Conditional [B]reakpoint" })

	map("n", "<leader>dlp", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end, { desc = "Debug: Set [L]og [P]oint" })

	map("n", "<leader>dr", function()
		dap.repl.open()
	end, { desc = "Debug: Open [R]EPL" })
	map("n", "<leader>dl", function()
		dap.run_last()
	end, { desc = "Debug: Run [L]ast" })

	if has_dap_view then
		map("n", "<leader>dv", function()
			dap_view.toggle()
		end, { desc = "Debug: Toggle [V]iew" })

		dap.listeners.after.event_initialized["dap_view_auto"] = function()
			dap_view.open()
		end

		dap.listeners.before.event_terminated["dap_view_auto"] = function()
			dap_view.close()
		end

		dap.listeners.before.event_exited["dap_view_auto"] = function()
			dap_view.close()
		end
	end
end

--#endregion
