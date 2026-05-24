local gh = require("util").pack.gh

vim.pack.add({
	gh("mason-org/mason.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
})

require("mason").setup({
	registries = {
		"github:Crashdummyy/mason-registry",
		"github:mason-org/mason-registry",
	},
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
		-- LUA
		"lua-language-server",
		"stylua",

		-- TypeScript / JavaScript
		"tsgo",

		-- PRETTIER
		"prettierd",

		-- ESLINT
		"eslint_d",
		"eslint-lsp",

		-- "vtsls",
		-- "vue-language-server",

		-- "oxlint",
		-- "oxfmt",

		-- GO
		"gopls",
		"gofumpt",
		"goimports",

		-- PYTHON
		"ty",
		"ruff",

		-- JAVA
		"jdtls",
		"java-test",
		"java-debug-adapter",
		"vscode-spring-boot-tools",

		-- CSHARP
		"roslyn",

		-- HTML
		"superhtml",
		-- "htmx-lsp",

		-- CSS
		"css-lsp",
		"css-variables-language-server",
		"tailwindcss-language-server",

		-- GLSL
		-- "glsl_analyzer",

		-- FISH
		"fish-lsp",
		-- BASH
		"bash-language-server",

		-- TOML
		"tombi",
		-- YAML
		"yaml-language-server",
		-- JSON
		"json-lsp",

		-- DOCKER
		-- "docker-language-server",
	},
})
