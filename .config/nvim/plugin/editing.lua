require("mini.ai").setup({})
require("mini.bracketed").setup({})

require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.align").setup({})
require("mini.splitjoin").setup({})

require("mini.move").setup({})

require("blink.indent").setup({})

require("rainbow-delimiters")

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
