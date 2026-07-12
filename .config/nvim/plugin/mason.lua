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

		"oxlint",
		"oxfmt",

		-- GO
		"gopls",
		"gofumpt",
		"goimports",

		-- PYTHON
		"ty",
		"ruff",

		-- C/C++
		"clangd",

		-- JAVA
		"jdtls",
		"java-test",
		"java-debug-adapter",
		"vscode-spring-boot-tools",

		-- CSHARP
		"roslyn",

		-- HTML
		-- "superhtml",
		"html-lsp",
		"htmx-lsp",
		"jinja-lsp",

		-- CSS
		"css-lsp",
		"css-variables-language-server",
		"tailwindcss-language-server",

		-- GLSL
		-- "glsl_analyzer",

		-- SQL
		"sqls",
		"sleek",

		-- FISH
		"fish-lsp",
		-- BASH
		"bash-language-server",

		-- TYPST
		"tinymist",

		-- TOML
		"tombi",

		-- YAML
		"yaml-language-server",

		-- JSON
		"json-lsp",

		-- NIX
		"nil",

		-- DOCKER
		-- "docker-language-server",
	},
})
