local gh = require("util").pack.gh

vim.pack.add({
	gh("nvim-mini/mini.nvim"),
})

require("mini.tabline").setup({
	format = function(buf_id, label)
		local suffix = vim.bo[buf_id].modified and "+ " or ""
		return MiniTabline.default_format(buf_id, label) .. suffix
	end,
})

require("mini.statusline").setup({ use_icons = true })

vim.pack.add({
	gh("rachartier/tiny-cmdline.nvim"),
})

require("vim._core.ui2").enable({})

vim.o.cmdheight = 1

---@diagnostic disable: missing-fields
require("tiny-cmdline").setup({ on_reposition = require("tiny-cmdline").adapters.blink })
---@diagnostic enable: missing-fields

vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
