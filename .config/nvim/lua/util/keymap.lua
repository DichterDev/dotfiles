local M = {}

---@alias Mode 'n'|'v'|'x'|'s'|'o'|'i'|'l'|'c'|'t'|''

---@param modes Mode|Mode[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
M.set = function(modes, lhs, rhs, opts)
	---@type vim.keymap.set.Opts
	local args = {
		noremap = true,
		silent = modes ~= "c",
		nowait = modes ~= "t",
	}

	opts = opts or {}

	args = vim.tbl_deep_extend("force", args, opts)

	vim.keymap.set(modes, lhs, rhs, args)
end

return M
