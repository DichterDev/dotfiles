local function get_package_name()
	local path = vim.fn.expand("%:p:h")
	local _, match = path:find("src/.-/java/")
	if match then
		return (path:sub(match + 1):gsub("/", "."))
	end
	return ""
end

local function get_class_name()
	return vim.fn.expand("%:t:r")
end

local function package_line()
	local pkg = get_package_name()

	return pkg ~= "" and ("package " .. pkg .. ";\n\n") or ""
end

---@param start? number
local function rest_method(start)
	local start = start or 2

	return table.concat({
		string.format("public ResponseEntity<Void> $%s($%s) {", start, start + 1),
		"\t$0",
		"\treturn ResponseEntity.ok().build();",
		"}",
	}, "\n")
end

return {
	{
		function()
			return {
				prefix = "pkg",
				body = "package " .. get_package_name() .. ";$0",
			}
		end,
		function()
			return {
				prefix = "cl",
				body = package_line() .. "public class " .. get_class_name() .. " {\n$0\n}",
			}
		end,
		function()
			return {
				prefix = "restc",
				body = table.concat({
					package_line(),
					"@RestController",
					"public class" .. get_class_name() .. " {",
					"\t$0",
					"}",
				}, "\n"),
			}
		end,
		function()
			return {
				prefix = "getm",
				body = '@GetMapping("$1")\n' .. rest_method(),
			}
		end,
		function()
			return {
				prefix = "postm",
				body = '@PostMapping("$1")\n' .. rest_method(),
			}
		end,
	},
}
