local M = {}

---@param events vim.api.keyset.events|vim.api.keyset.events[]
---@param group string
---@param opts vim.api.keyset.create_autocmd
M.autocmd = function(events, group, opts)
	local augroup = vim.api.nvim_create_augroup("user:" .. group, { clear = false })

	---@type vim.api.keyset.create_autocmd
	local args = vim.tbl_deep_extend("force", {}, opts or {})
	args.group = augroup

	vim.api.nvim_create_autocmd(events, args)
end

return M
