local gh = require("util").pack.gh
vim.pack.add({ gh("monaqa/dial.nvim") })

local dial = require("dial.map")
local augend = require("dial.augend")

require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal,
		augend.constant.alias.bool,
		augend.constant.new({
			elements = { "and", "or" },
			word = true,
			cyclic = true,
		}),
	},
})

vim.keymap.set("n", "<C-a>", dial.inc_normal(), { desc = "Increment/Toggle" })
vim.keymap.set("n", "<C-x>", dial.dec_normal(), { desc = "Decrement/Toggle" })
