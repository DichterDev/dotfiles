---@param cols number
local function gen_table(cols)
	local columns = "auto"
	if cols >= 1 then
		local tbl = {}
		for _ = 1, cols do
			table.insert(tbl, "auto")
		end

		columns = "(" .. table.concat(tbl, ", ") .. ")"
	end

	return table.concat({
		"#table(",
		"\tcolumns: " .. columns .. ",",
		"\t$0",
		")",
	}, "\n")
end

return {
	{
		function()
			return {
				prefix = "bold",
				body = "*$0*",
			}
		end,
		function()
			return {
				prefix = "italic",
				body = "_$0_",
			}
		end,
		function()
			return {
				prefix = "link",
				body = '#link("$1")[$0]',
			}
		end,
		function()
			return {
				prefix = "code",
				body = "```$1\n$0\n```",
			}
		end,
		function()
			return {
				prefix = "inline",
				body = "`$0`",
			}
		end,
		function()
			return {
				prefix = "icode",
				body = "```$1 $0```",
			}
		end,
		function()
			local tables = {}
			for x = 1, 8 do
				table.insert(tables, {
					prefix = "tbl" .. x,
					body = gen_table(x),
				})
			end

			return tables
		end,
	},
}
