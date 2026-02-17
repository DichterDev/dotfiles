---@type Server
local M = {}

local capabilities = {
	"documentFormattingProvider",
}

M.config = {
	name = "superhtml",
	cmd = { "superhtml", "lsp", "--syntax-only" },
	capabilities = require("lsp.defaults").capabilities(capabilities),
	filetypes = { "html" },
}

return M
