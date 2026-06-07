PackAdd("gh:nvim-mini/mini.nvim")

require("mini.ai").setup({})
require("mini.bracketed").setup({})

require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.align").setup({})
require("mini.splitjoin").setup({})

require("mini.move").setup({})

PackAdd("gh:saghen/blink.indent")

require("blink.indent").setup({})

PackAdd("gh:HiPhish/rainbow-delimiters.nvim")

require("rainbow-delimiters")

PackAdd("gh:folke/flash.nvim")

require("flash").setup({})

Map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end)

Map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end)

Map({ "n", "x", "o" }, "r", function()
	require("flash").remote()
end)

Map({ "n", "x", "o" }, "R", function()
	require("flash").treesitter_search()
end)

Map("c", "<C-s>", function()
	require("flash").toggle()
end)
