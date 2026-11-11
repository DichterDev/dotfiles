local M = {}

M.tests = {
	{
		"s / \n",
		{
			"foo/bar/asdfasdf",
			"foo/foo/as",
			"foo/bar/ab",
			"bar/bar/asdfase",
			"foo/bar/asdf",
		},
		{
			"bar/bar/asdfase",

			"foo/bar/as",
			"foo/bar/abc",
			"foo/bar/adasdda",

			"foo/foo/as",
		},
	},
}

return M
