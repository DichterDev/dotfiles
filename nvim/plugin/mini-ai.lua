local ai = require("mini.ai")
local extra = require("mini.extra")

require("mini.ai").setup({
	mappings = {
		around = "a",
		inside = "i",

		around_next = "an",
		inside_next = "in",
		around_last = "al",
		inside_last = "il",

		goto_left = "g[",
		goto_right = "g]",
	},
	n_lines = 50,
	search_method = "cover_or_next",
	silent = false,
	custom_textobjects = {

		B = extra.gen_ai_spec.buffer(),
		D = extra.gen_ai_spec.diagnostic(),
		I = extra.gen_ai_spec.indent(),
		L = extra.gen_ai_spec.line(),
		N = extra.gen_ai_spec.number(),

		F = ai.gen_spec.treesitter({
			a = "@function.outer",
			i = "@function.inner",
		}),

		c = ai.gen_spec.treesitter({
			a = "@class.outer",
			i = "@class.inner",
		}),

		o = ai.gen_spec.treesitter({
			a = { "@conditional.outer", "@loop.outer" },
			i = { "@conditional.inner", "@loop.inner" },
		}),
	},
})
