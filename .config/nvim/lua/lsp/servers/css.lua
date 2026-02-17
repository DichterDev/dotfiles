---@type Server
local M = {}

M.config = {
	name = "css",
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}

return M
