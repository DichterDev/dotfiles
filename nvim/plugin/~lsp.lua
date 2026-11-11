vim.lsp.inlay_hint.enable(true)

local capabilities = require("blink-cmp").get_lsp_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.enable({
	"bashls",
	"clangd",
	"csskit",
	"cssls",
	"fish_lsp",
	"gopls",
	"html",
	"jinja_lsp",
	"jsonls",
	"lua_ls",
	"oxlint",
	"qml-language-server",
	"roslyn",
	"ruff",
	"rust_analyzer",
	"solang",
	"sqls",
	"tailwindcss",
	"tinymist",
	"tombi",
	"tsc",
	"ty",
	"vtsls",
	"vue_ls",
	"yamlls",
	-- "htmx",
	-- "nil_ls",
	-- "qmlls",
	-- "superhtml",
})
