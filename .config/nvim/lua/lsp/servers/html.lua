---@type vim.lsp.Config
local html = {
	cmd = { "superhtml", "lsp", "--syntax-only" },
	capabilities = require("lsp.defaults").capabilities({ "documentFormattingProvider" }),
}

vim.lsp.config("superhtml", html)
vim.lsp.enable("superhtml")

---@type vim.lsp.Config
local htmx = {
	capabilities = require("lsp.defaults").capabilities({}),
}
-- WARN: not working and breaks tsgo
-- vim.lsp.config("htmx", htmx)
-- vim.lsp.enable("htmx")
