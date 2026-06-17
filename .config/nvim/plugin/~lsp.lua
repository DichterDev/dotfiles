vim.lsp.config("*", {
	capabilities = require("blink-cmp").get_lsp_capabilities(),
})

vim.lsp.enable({
	"clangd",
	"eslint",
	"fish_lsp",
	"gopls",
	"jsonls",
	"lua_ls",
	"roslyn",
	"ruff",
	"rust_analyzer",
	"superhtml",
	"tailwindcss",
	"tinymist",
	"vtsls",
	"vue_ls",
	"yamlls",
})
