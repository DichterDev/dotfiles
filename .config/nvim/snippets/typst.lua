local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local page = fmt(
	[[
      #set page(
        paper: "a4",
        margin: (x: 2.5cm, y: 3cm),
        numbering: "1",
        header: align(right)[{}],
      )
    ]],
	{ i(0) }
)
local text = fmt(
	[[
    #set text(
      font: "Roboto",
      size: 11pt,
      lang: "en",
    )
    ]],
	{}
)
local config = fmt(
	[[
    {}

    {}
    ]],
	{ page, text }
)

ls.add_snippets("typst", {
	s("tpage", page),
	s("ttext", text),
	s("tcfg", config),
})
