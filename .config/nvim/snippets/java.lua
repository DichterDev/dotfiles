local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node

local function get_package_name()
	local path = vim.fn.expand("%:p:h")
	local _, match = path:find("src/.-/java/")
	if match then
		return (path:sub(match + 1):gsub("/", "."))
	end
	return ""
end

ls.add_snippets("java", {
	s("package", {
		t("package "),
		f(get_package_name, {}),
		t(";"),
	}),
})
