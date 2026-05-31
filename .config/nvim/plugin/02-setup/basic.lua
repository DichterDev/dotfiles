local gh = require("util").pack.gh

vim.pack.add({ gh("nvim-mini/mini.nvim") })

require("mini.basics").setup({
	options = {
		win_borders = "rounded",
	},
	mappings = {
		windows = true,
	},
})

require("mini.extra").setup({})
require("mini.icons").setup({})

package.preload["nvim-web-devicons"] = function()
	require("mini.icons").mock_nvim_web_devicons()
	return package.loaded["nvim-web-devicons"]
end

local map_multistep = require("mini.keymap").map_multistep

map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })
