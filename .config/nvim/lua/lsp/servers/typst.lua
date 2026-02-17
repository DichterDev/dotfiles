---@type Server
local M = {}

M.config = {
	name = "typst",
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = "typstyle",
		exportPdf = "disable",
		semanticTokens = "disable",
	},
}

return M
