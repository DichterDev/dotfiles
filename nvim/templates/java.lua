local function pkg()
	return ""
end

local function file()
	return ""
end

return {
	default = "class",
	body = function()
		return table.concat({
			"package " .. pkg(),
			"",
			"$0",
		}, "\n")
	end,
	inner = { file() },
}
