local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_filename(args, snip)
	return snip.env.TM_FILENAME_BASE or "Component"
end

local import = fmt(
	[[
      import {{ {} }} from "react";
      ]],
	{ i(0) }
)

ls.add_snippets("typescriptreact", {
	s("rimp", import),
	s(
		"rcmp",
		fmt(
			[[
      {}

      export default function {}() {{
        return (
          <div>
          {}
          <div>
        );
      }};
      ]],
			{
				import,
				f(get_filename, {}),
				i(1),
			}
		)
	),
})
