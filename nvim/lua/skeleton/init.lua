local M = {}

local ns = vim.api.nvim_create_augroup("skeleton", { clear = true })

M.config = {
	dir = vim.fn.stdpath("config") .. "/templates",
	ft_to_ext = {
		python = "py",
		java = "java",
		lua = "lua",
	},
}

function M.setup() end

function M.load_dir() end

function M.setup_autocmd()
	vim.api.nvim_create_autocmd("BufNewFile", {
		group = ns,
		callback = function(ev) end,
	})
end

return M
