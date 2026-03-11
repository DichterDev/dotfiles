---@type LazySpec
return {
	{
		"mason-org/mason.nvim",
		---@module "mason"
		---@type MasonSettings
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		---@module "mason-tool-installer"
		---@type MasonToolInstallerSettings
		opts = {
			ensure_installed = {
				-- LANGUAGE
				--- LUA
				"lua-language-server",
				"stylua",
				--- JS & TS
				"vtsls",
				"tsgo",
				"oxlint",
				"oxfmt",
				"vue-language-server",
				--- GO
				"gopls",
				"gofumpt",
				"goimports",
				--- PYTHON
				"ty",
				"ruff",
				--- RUST
				--- "rust-analyzer",
				--- "rustfmt",
				--- JAVA
				"jdtls",
				"java-test",
				"java-debug-adapter",
				"google-java-format",
				"vscode-spring-boot-tools",
				"groovy-language-server",

				-- WEB
				"superhtml",
				"htmx-lsp",
				"css-lsp",
				"css-variables-language-server",
				"tailwindcss-language-server",
				"glsl_analyzer",

				-- MARKUP
				--- TYPST
				"tinymist",
				-- MARKDOWN
				"marksman",

				-- SCRIPT
				"fish-lsp",
				"bash-language-server",

				-- DATA
				"tombi",
				"yaml-language-server",
				"json-lsp",
				--- DOCKER
				"docker-language-server",
			},
		},
	},
}
