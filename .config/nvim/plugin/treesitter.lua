Autocmd("PackChanged", "ts-update", {
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

local ts = require("nvim-treesitter")

require("nvim-treesitter.config")

ts.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

-- Auto Parser Install
-- src: https://www.reddit.com/r/neovim/comments/1sezoxf
Autocmd("FileType", "ts-parser-install", {
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

Autocmd("ColorScheme", "ts-context-bg", {
	callback = function()
		RemoveBG("TreesitterContext")
	end,
})

require("nvim-ts-autotag").setup({})
