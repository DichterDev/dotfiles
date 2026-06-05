local M = {}

---@param url string
M.gh = function(url)
	return "https://github.com/" .. url
end

local prefixes = {
	["gh:"] = "https://github.com/",
	["cb:"] = "https://codeberg.com/",
	["lr:"] = "https://luarocks.com/",
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

---@param specs (string|vim.pack.Spec)[]
---@param opts? vim.pack.keyset.add
M.add = function(specs, opts)
	if type(specs) == "string" or (type(specs) == "table" and specs[1] == nil and not vim.islist(specs)) then
		specs = { specs }
	end

	local pkgs = {}

	for _, spec in ipairs(specs) do
		if type(spec) == "string" then
			table.insert(pkgs, expand_url(spec))
		elseif type(spec) == "table" then
			if type(spec.src) == "string" then
				spec.src = expand_url(spec.src)
			end
			table.insert(pkgs, spec)
		end
	end

	vim.pack.add(pkgs, opts)
end

return M
