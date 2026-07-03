vim.lsp.config("*", {
	capabilities = require("blink-cmp").get_lsp_capabilities(),
})

vim.lsp.enable({
	"clangd",
	"bashls",
	"fish_lsp",
	"gopls",
	"html",
	"htmx",
	"jinja_lsp",
	"jsonls",
	"lua_ls",
	"oxlint",
	"roslyn",
	"ruff",
	"rust_analyzer",
	-- "superhtml",
	"sqlls",
	"tailwindcss",
	"tinymist",
	"tombi",
	"tsgo",
	"vtsls",
	"vue_ls",
	"yamlls",
})
