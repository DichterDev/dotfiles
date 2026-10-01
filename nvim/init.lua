local util = require("util")

Autocmd = util.cmd.autocmd
Usercmd = util.cmd.usercmd

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

--#region AUTOCMD

Autocmd("ColorScheme", "transparent-bg", {
	callback = function()
		local set = vim.api.nvim_set_hl
		local prop = util.hl.get_prop

		local hls = vim.api.nvim_get_hl(0, { link = true })

		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })

		for name, hl in pairs(hls) do
			if hl.link == "Normal" then
				if not hl.bg then
					set(0, name, { bg = normal.bg, link = "", update = true })
				end
			end
		end

		local keyword_fg = prop("Keyword", "fg")
		local comment_fg = prop("Comment", "fg")
		local const_fg = prop("Constant", "fg")

		set(0, "LspInlayHint", { fg = comment_fg, update = true })
		set(0, "FloatTitle", { fg = keyword_fg, bg = normal.bg, update = true })
		set(0, "FloatBorder", { fg = keyword_fg, bg = normal.bg, update = true })
		set(0, "NormalFloat", { bg = normal.bg, update = true })
		set(0, "CursorLineNr", { fg = const_fg, update = true })
	end,
})

Autocmd("ColorScheme", "remove-bg", {
	callback = function()
		for _, hl in ipairs({
			"Normal",
			"NormalNC",
			"Folded",
			"FoldColumn",
			"SignColumn",
			"TablineFill",
			"CursorLineNr",
			"FloatBorder",
			"FloatTitle",
			"NormalFloat",
			"LineNr",
		}) do
			vim.api.nvim_set_hl(0, hl, { bg = "NONE", update = true })
		end
	end,
})

Autocmd("ColorScheme", "diagnostic-remove-bg", {
	callback = function()
		for _, name in ipairs({ "Ok", "Hint", "Info", "Warn", "Error" }) do
			vim.api.nvim_set_hl(0, "DiagnosticSign" .. name, { bg = "NONE", update = true })
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

Autocmd("FileType", "proper-format-options", {
	pattern = { "*" },
	callback = function(ev)
		vim.bo[ev.buf].formatoptions = vim.bo[ev.buf].formatoptions:gsub("[co]", "")
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

vim.cmd.packadd("nvim.undotree")

vim.cmd.packadd("nohlsearch")

local packadd = require("core.pack").add

packadd("Colorschemes", {
	"https://github.com/catppuccin/nvim",
	"https://github.com/sainnhe/sonokai",
	"https://github.com/jpwol/thorn.nvim",
	"https://github.com/pankvitek/bonbon.nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/navarasu/onedark.nvim",
	"https://github.com/darianmorat/gruvdark.nvim",
	"https://github.com/scottmckendry/cyberdream.nvim",
})

packadd("Plugins", {
	"https://github.com/nvim-mini/mini.nvim",

	"https://codeberg.org/cryptomilk/nvim-pack-ui",

	"https://github.com/monaqa/dial.nvim",
	"https://gitlab.com/itaranto/id3.nvim",
	"https://github.com/Aasim-A/scrollEOF.nvim",
	"https://github.com/chrisgrieser/nvim-spider",
	"https://github.com/catgoose/nvim-colorizer.lua",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/HiPhish/rainbow-delimiters.nvim",

	"https://github.com/stevearc/aerial.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/quicker.nvim",
	"https://github.com/stevearc/overseer.nvim",

	"https://github.com/folke/flash.nvim",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/folke/todo-comments.nvim",

	"https://github.com/rachartier/tiny-glimmer.nvim",
	"https://github.com/rachartier/tiny-cmdline.nvim",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",

	{ spec = "https://github.com/kevinhwang91/nvim-ufo", deps = { "https://github.com/kevinhwang91/promise-async" } },

	["git"] = {
		"https://github.com/lewis6991/gitsigns.nvim",
		{ spec = "https://github.com/NeogitOrg/neogit", deps = { "https://github.com/sindrets/diffview.nvim" } },
	},

	["notify"] = {
		{ spec = "https://github.com/j-hui/fidget.nvim", deps = { "https://github.com/Bilal2453/luvit-meta" } },
	},

	["treesitter"] = {
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/nvim-treesitter/nvim-treesitter-context",
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
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
		"https://github.com/onlyati/quadlet-lsp.nvim",
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
