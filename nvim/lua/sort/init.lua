local M = {}

-- sort.nvim
--
-- Usage:
-- :Sort <flags> <del> <sep>

M.config = {
	flags = {
		["a"] = "alphanumeric",
		["l"] = "length",
		["r"] = "reverse",
		["i"] = "ignorecase",
	},
}

function M.setup(opts)
	opts = opts or {}
	M.config = vim.tbl_deep_extend("force", M.config, opts)
end

return M
