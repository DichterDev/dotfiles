local function get_package_name()
	local path = vim.fn.expand("%:p:h")
	local _, match = path:find("src/.-/java/")
	if match then
		return (path:sub(match + 1):gsub("/", "."))
	end
	return ""
end

return {
	{
		function()
			return {
				prefix = "package",
				body = "package " .. get_package_name() .. ";$0",
			}
		end,
	},
}
