---@type Server
local M = {}

M.config = {
	name = "htmx",
	cmd = { "htmx-lsp" },
	filetypes = { "html", "templ", "vue" },
}

return M
