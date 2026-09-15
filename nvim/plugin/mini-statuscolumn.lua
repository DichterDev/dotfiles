require("mini.statuscolumn").setup({
	content = require("mini.statuscolumn").gen_content.main({
		-- `f` (fold), `s` (sign), `l` (lnum), and `=` (as `%=` in |'statusline'| syntax)
		{ format = "fl=s", sep = "▏" },
		{ ltype = "virt", lnum = "•" },
		{ ltype = "wrap", lnum = "↳" },
		{ win = "inactive", fold = "", lnum = "", sign = "" },
	}),
	dim_inactive = false,
})
