local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local generate_cells = function(_, snip)
	local cols = tonumber(snip.captures[1]) or 1
	local nodes = {}
	for n = 1, cols do
		table.insert(nodes, i(n, "item " .. n))
		if n < cols then
			table.insert(nodes, ls.text_node(", "))
		end
	end
	return sn(nil, nodes)
end

ls.add_snippets("typst", {
	s(
		"template",
		fmt(
			[[
      #let template(doc) = {{
        set page(
          paper: "a4",
          margin: (x: 2.5cm, y: 3cm),
          numbering: "1",
          header: align(right)[{}],
        )

        set text(
          font: "Roboto",
          size: 11pt,
          lang: "en",
        )

        doc
      }}

      #show: doc => template(doc)
      ]],
			{ i(1) }
		)
	),
	s(
		"code",
		fmt(
			[[
      ```{}
      {}
      ```
      ]],
			{ i(1), i(2) }
		)
	),
	s(
		{ trig = "tbl(%d+)", regTrig = true, name = "table" },
		fmt(
			[[
        #table(
          columns: ({}),
          {}
        )
      ]],
			{
				f(function(_, snip)
					local cols = tonumber(snip.captures[1]) or 1
					return string.rep("1fr", cols, ", ")
				end),
				d(1, generate_cells),
			}
		)
	),
})
