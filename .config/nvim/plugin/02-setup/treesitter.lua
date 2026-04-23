local gh = require("util").pack.gh
local remove_bg = require("util").hl.remove_bg

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-context"),
	gh("windwp/nvim-ts-autotag"),
})

local ts = require("nvim-treesitter")

require("nvim-treesitter.config")

ts.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

-- Auto Parser Install
-- src: https://www.reddit.com/r/neovim/comments/1sezoxf
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		local available_langs = require("nvim-treesitter").get_available()
		local is_available = vim.tbl_contains(available_langs, lang)
		if is_available then
			require("nvim-treesitter").install(lang):wait()
			vim.treesitter.start()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		remove_bg("TreesitterContext")
	end,
})

require("nvim-ts-autotag").setup({})
