local hipatterns = require("mini.hipatterns")
local words = require("mini.extra").gen_highlighter.words
hipatterns.setup({
	highlighters = {
		fixme = words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
		hack = words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
		todo = words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
		note = words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
