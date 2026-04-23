local M = {}

---@param url string
M.gh = function(url)
	return "https://github.com/" .. url
end

return M
