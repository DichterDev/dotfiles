local M = {}

M.buffer = {}

M.buffer[1] = {
	{},
}

M.tree = {}

M.tree[1] = {
	{
		"foo/bar/test1.lua",
		"foo/bar/test2.lua",
		"foo/bar/test3.lua",
		"foo/baz/test1.lua",
		"foo/baz/test2.lua",
		"foo/baz/test3.lua",
	},
	{
		"foo",
		"\tbar/",
		"\t\ttest1.lua",
		"\t\ttest2.lua",
		"\t\ttest3.lua",
		"\tbaz/",
		"\t\ttest1.lua",
		"\t\ttest2.lua",
		"\t\ttest3.lua",
	},
}

return M
