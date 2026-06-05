local util = require("util")

Gh = util.pack.gh
Map = util.keymap.set
Autocmd = util.autocmd.autocmd
RemoveBG = util.hl.remove_bg
LspSetup = util.lsp.setup

-- GLOBALS

vim.g.mapleader = " "
vim.g.maplocalleader = ","

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

-- KEYMAPS

Map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
Map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

Map({ "n", "x", "o" }, "ö", "[", { desc = "Left bracket [", remap = true })
Map({ "n", "x", "o" }, "ä", "]", { desc = "Right bracket ]", remap = true })
Map({ "n", "x", "o" }, "ü", "\\", { desc = "Backslash \\", remap = true })

Map("n", "<leader>a", "ggVG", { desc = "Visual select all" })

Map("n", "<leader>Q", ":qa<CR>", { desc = "[Q]it all" })

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

-- AUTOCMD

Autocmd("ColorScheme", "color-scheme", {
	callback = function()
		RemoveBG("Normal")
		RemoveBG("FloatBorder")
		RemoveBG("FloatTitle")
	end,
})

-- Diagnostic

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})

Autocmd("ColorScheme", "diagnostic-color-scheme", {
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

-- LSP
vim.lsp.inlay_hint.enable(false)

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

vim.cmd.packadd("nvim.undotree")

Map("n", "<leader>u", ":Undotree<CR>", { desc = "[u]ndotree" })

vim.cmd.packadd("nohlsearch")
