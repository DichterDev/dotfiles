local util = require("util")

Map = util.keymap.set
Autocmd = util.cmd.autocmd
Usercmd = util.cmd.usercmd
RemoveBG = util.hl.remove_bg
PackAdd = util.pack.add

-- GLOBALS

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

-- ENV

vim.env.JAVA_HOME = "/usr/lib/jvm/default"
vim.env.JDK21 = "/usr/lib/jvm/java-21-openjdk/"
vim.env.JDK25 = "/usr/lib/jvm/java-25-openjdk/"

-- OPTIONS

vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true
-- vim.o.showbreak = "↳"

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true

vim.o.list = true
vim.o.listchars = "trail:·,tab:»·,nbsp:+"

vim.o.scrolloff = 12
vim.o.sidescrolloff = 8
vim.o.undofile = true

vim.o.swapfile = false

vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.conceallevel = 0
vim.o.wildmode = "longest:full,full"
vim.o.virtualedit = "block"

vim.o.sh = "/bin/fish"
vim.o.background = "dark"
vim.o.termguicolors = true

vim.o.winblend = 0
vim.o.pumblend = 0

-- KEYMAPS

Map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
Map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

Map({ "n", "x", "o" }, "ö", "[", { desc = "Left bracket [", remap = true })
Map({ "n", "x", "o" }, "ä", "]", { desc = "Right bracket ]", remap = true })
Map({ "n", "x", "o" }, "ü", "\\", { desc = "Backslash \\", remap = true })

Map("n", "<leader>a", "ggVG", { desc = "Visual select all" })

Map("n", "<leader>Q", ":qa<CR>", { desc = "[Q]it all" })

Map("n", "gh", ":norm 0<CR>")
Map("n", "gl", ":norm $<CR>")

-- src: https://www.reddit.com/r/neovim/comments/1scauyd/comment/oecobq8/
Map({ "x", "o" }, "v", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_parent(vim.v.count1)
	else
		vim.lsp.buf.selection_range(vim.v.count1)
	end
end, { desc = "[v]isual increment" })

Map({ "x", "o" }, "V", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_child(vim.v.count1)
	else
		vim.lsp.buf.selection_range(-vim.v.count1)
	end
end, { desc = "[V]isual decrement" })

Map("n", "<leader>vs", "<CMD>vsplit<CR>", { desc = "[v]ertical [s]plit" })
Map("n", "<leader>hs", "<CMD>:hsplit", { desc = "[h]orizontal [s]plit" })

Map({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to clipboard" })
Map("n", "<leader>yy", '"+yy', { desc = "[yy]ank to clipboard" })
Map("n", "<leader>Y", '"+y_', { desc = "[Y]ank to clipboard" })

Map({ "n", "v" }, "<leader>p", '"+p', { desc = "[p]aste from clipboard" })
Map({ "n", "v" }, "<leader>P", '"+P"', { desc = "[P]aste from clipboard" })

Map("n", "<leader>d", vim.diagnostic.open_float, { desc = "[d]iagnostic float" })

-- Diagnostic

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})

-- Fletypes

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

-- LSP

vim.lsp.inlay_hint.enable(false)

-- AUTOCMD

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

		set_hl(0, "FloatTitle", { fg = keyword_fg, bg = normal.bg, update = true })
		set_hl(0, "FloatBorder", { fg = keyword_fg, bg = normal.bg, update = true })
		set_hl(0, "NormalFloat", { bg = normal.bg, update = true })

		set_hl(0, "Normal", { bg = "NONE", update = true })
		set_hl(0, "NormalNC", { bg = "NONE", update = true })
		set_hl(0, "TablineFill", { bg = "NONE", update = true })
	end,
})

Autocmd("ColorScheme", "remove-bg", {
	callback = function()
		local hls = util.hl.RM_BG

		for _, name in ipairs(hls) do
			vim.api.nvim_set_hl(0, name, { bg = "NONE", link = "", update = true })
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

-- ROCKS
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

-- PACK

vim.cmd.packadd("nvim.undotree")

Map("n", "<leader>u", ":Undotree<CR>", { desc = "[u]ndotree" })

vim.cmd.packadd("nohlsearch")

-- COLOR
PackAdd({
	"gh:rebelot/kanagawa.nvim",
	"gh:darianmorat/gruvdark.nvim",
	"gh:catppuccin/nvim",
	"gh:pankvitek/bonbon.nvim",
	"gh:navarasu/onedark.nvim",
	"gh:scottmckendry/cyberdream.nvim",
	"gh:sainnhe/sonokai",
	"gh:jpwol/thorn.nvim",
})

-- PLUGIN
PackAdd({
	"cb:cryptomilk/nvim-pack-ui",

	"gh:monaqa/dial.nvim",

	"gh:Amansingh-afk/milli.nvim",
	"gh:rafamadriz/friendly-snippets",
	"gh:Aasim-A/scrollEOF.nvim",
	"gh:HiPhish/rainbow-delimiters.nvim",
	"gh:catgoose/nvim-colorizer.lua",
	"gh:chrisgrieser/nvim-spider",
	"gh:tris203/precognition.nvim",

	"gh:Bilal2453/luvit-meta",
	"gh:j-hui/fidget.nvim",

	"gh:chomosuke/typst-preview.nvim",
	"gh:quarto-dev/quarto-nvim",
	"gh:jmbuhr/otter.nvim",
	"gh:hakonharnes/img-clip.nvim",

	-- TREESITTER
	"gh:nvim-treesitter/nvim-treesitter",
	"gh:nvim-treesitter/nvim-treesitter-context",
	"gh:windwp/nvim-ts-autotag",

	-- MASON
	"gh:mason-org/mason.nvim",
	"gh:WhoIsSethDaniel/mason-tool-installer.nvim",

	-- LSP
	"gh:seblyng/roslyn.nvim",
	"gh:neovim/nvim-lspconfig",
	"gh:mfussenegger/nvim-jdtls",
	-- "gh:idelice/nvim-jls",

	-- STEVEARC
	"gh:stevearc/oil.nvim",
	"gh:stevearc/aerial.nvim",
	"gh:stevearc/conform.nvim",
	"gh:stevearc/quicker.nvim",
	"gh:stevearc/overseer.nvim",

	-- FOLKE
	"gh:folke/flash.nvim",
	"gh:folke/lazydev.nvim",
	"gh:folke/todo-comments.nvim",

	-- FOLDING
	"gh:kevinhwang91/nvim-ufo",
	"gh:kevinhwang91/promise-async",

	{
		src = "gh:nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	"gh:nvim-lua/plenary.nvim",
	"gh:MunifTanjim/nui.nvim",

	-- FZF
	"gh:ibhagwan/fzf-lua",
	"gh:stephansama/fzf-nerdfont.nvim",

	-- BLINK
	"gh:saghen/blink.indent",
	{
		src = "gh:saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
})
