vim.lsp.config("*", {
	capabilities = require("blink-cmp").get_lsp_capabilities(),
})

vim.lsp.enable({
	"clangd",
	"fish_lsp",
	"gopls",
	"jsonls",
	"lua_ls",
	"oxlint",
	"roslyn",
	"ruff",
	"rust_analyzer",
	"superhtml",
	"tailwindcss",
	"tinymist",
	"tombi",
	"tsgo",
	"vtsls",
	"vue_ls",
	"yamlls",
})
