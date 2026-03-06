local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node

ls.add_snippets("groovy", {
	s("plugin_lombok", {
		t("id 'io.freefair.lombok' version '9.2.0'"),
	}),
})
