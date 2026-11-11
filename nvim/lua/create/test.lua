local parser = require("create.parser")

local M = {}

M.tests = {
	{ "foo/{foo, bar}.lua", { "foo/foo.lua", "foo/bar.lua" } },
	{ "{foo, bar}/foo.lua", { "foo/foo.lua", "bar/foo.lua" } },
	{
		"foo/bar..10.lua",
		{
			"foo/bar_00.lua",
			"foo/bar_01.lua",
			"foo/bar_02.lua",
			"foo/bar_03.lua",
			"foo/bar_04.lua",
			"foo/bar_05.lua",
			"foo/bar_06.lua",
			"foo/bar_07.lua",
			"foo/bar_08.lua",
			"foo/bar_09.lua",
		},
	},
	{
		"foo/bar..=10,5.lua",
		{
			"foo/bar_00.lua",
			"foo/bar_05.lua",
			"foo/bar_10.lua",
		},
	},
	{
		"foo/bar..10,5.lua",
		{
			"foo/bar_00.lua",
			"foo/bar_05.lua",
		},
	},
	{
		"foo/bar5..=10,2.lua",
		{
			"foo/bar_05.lua",
			"foo/bar_07.lua",
			"foo/bar_09.lua",
		},
	},
	{
		"foo/bar..010.lua",
		{
			"foo/bar_000.lua",
			"foo/bar_001.lua",
			"foo/bar_002.lua",
			"foo/bar_003.lua",
			"foo/bar_004.lua",
			"foo/bar_005.lua",
			"foo/bar_006.lua",
			"foo/bar_007.lua",
			"foo/bar_008.lua",
			"foo/bar_009.lua",
		},
	},
	{
		"src/{user, order}/{internal, external, core, public}/$2.java:pascal",
		{
			"src/user/internal/User.java",
			"src/user/external/User.java",
			"src/user/core/User.java",
			"src/user/public/User.java",
			"src/order/internal/Order.java",
			"src/order/external/Order.java",
			"src/order/core/Order.java",
			"src/order/public/Order.java",
		},
	},
}

function M.run_tests()
	local passed = 0
	local failed = 0

	for i, test in ipairs(M.tests) do
		local input, expected = test[1], test[2]
		local results = parser.parse(input)

		local actual_paths = {}
		for _, res in ipairs(results) do
			table.insert(actual_paths, res.path)
		end

		local is_match = #actual_paths == #expected
		if is_match then
			for idx = 1, #expected do
				if actual_paths[idx] ~= expected[idx] then
					is_match = false
					break
				end
			end
		end

		if is_match then
			passed = passed + 1
		else
			failed = failed + 1
			print(string.format("[FAIL] Test #%d: '%s'", i, input))
			print("  Expected: " .. vim.inspect(expected))
			print("  Got:      " .. vim.inspect(actual_paths))
		end
	end

	print(string.format("\nResults: %d Passed, %d Failed", passed, failed))
end

return M
