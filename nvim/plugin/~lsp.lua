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
	"cssls",
	"fish_lsp",
	"gopls",
	"html",
	-- "htmx",
	"jinja_lsp",
	"jsonls",
	"lua_ls",
	"nil_ls",
	"oxlint",
	-- "qmlls",
	"qml-language-server",
	"roslyn",
	"ruff",
	"rust_analyzer",
	-- "superhtml",
	"sqls",
	"tailwindcss",
	"tinymist",
	"tombi",
	"tsc",
	"ty",
	"vtsls",
	"vue_ls",
	"yamlls",
})
