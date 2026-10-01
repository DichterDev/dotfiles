require("vim._core.ui2").enable({})

vim.o.cmdheight = 0
vim.o.showcmdloc = "statusline"

---@diagnostic disable: missing-fields
require("tiny-cmdline").setup({ on_reposition = require("tiny-cmdline").adapters.blink })
---@diagnostic enable: missing-fields

Autocmd("ColorScheme", "tiny-cmdline-colorscheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "TinyCmdlineNormal", { link = "NormalFloat", update = true })
	end,
})
