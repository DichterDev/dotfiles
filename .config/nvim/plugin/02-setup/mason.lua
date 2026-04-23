local gh = require("util").pack.gh

vim.pack.add({
	gh("mason-org/mason.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"stylua",

		"tsgo",
		"prettierd",
		"eslint_d",
		"eslint-lsp",

		-- "vtsls",
		-- "vue-language-server",

		-- "oxlint",
		-- "oxfmt",

		"gopls",
		"gofumpt",
		"goimports",

		"ty",
		"ruff",

		"jdtls",
		"java-test",
		"java-debug-adapter",
		"google-java-format",
		"vscode-spring-boot-tools",

		"superhtml",
		-- "htmx-lsp",
		"css-lsp",
		"css-variables-language-server",
		"tailwindcss-language-server",
		-- "glsl_analyzer",

		"fish-lsp",
		"bash-language-server",

		"tombi",
		"yaml-language-server",
		"json-lsp",

		"docker-language-server",
	},
})
