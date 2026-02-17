---@type Server
local M = {}

local root_markers = {
	"package-lock.json",
	"yarn.lock",
	"pnpm-lock.yaml",
	"bun.lockb",
	"bun.lock",
}

vim.list_extend(root_markers, require("lsp.defaults").root_markers)

M.config = {
	name = "tsgo",
	cmd = { "tsgo", "--lsp", "--stdio" },
	filetypes = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
	},
	root_dir = function(bufnr, on_dir)
		local project_root = vim.fs.root(bufnr, root_markers)
		on_dir(project_root or vim.fn.getcwd())
	end,
}

return M
