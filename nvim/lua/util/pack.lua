local M = {}

---@alias Spec vim.pack.Spec | string

local prefixes = {
	["gh:"] = "https://github.com/",
	["gl:"] = "https://gitlab.com/",
	["cb:"] = "https://codeberg.org/",
	-- ["lr:"] = "https://luarocks.com/",
}

---@param url string
---@return string
local function expand_url(url)
	for prefix, base in pairs(prefixes) do
		if url:sub(1, #prefix) == prefix then
			return base .. url:sub(#prefix + 1)
		end
	end
	return url
end

---@param specs Spec | Spec[]
---@param opts? vim.pack.keyset.add
M.add = function(specs, opts)
	if type(specs) == "string" or (type(specs) == "table" and not vim.islist(specs)) then
		specs = { specs }
	end

	---@type Spec[]
	local pkgs = {}

	for _, spec in ipairs(specs) do
		if type(spec) == "string" then
			table.insert(pkgs, expand_url(spec))
		elseif type(spec) == "table" then
			if type(spec.src) == "string" then
				spec = vim.tbl_extend("force", spec, { src = expand_url(spec.src) })
			end
			table.insert(pkgs, spec)
		end
	end

	vim.pack.add(pkgs, opts)
end

return M
