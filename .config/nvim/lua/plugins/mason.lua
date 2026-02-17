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
				-- LUA
				"lua-language-server",
				"stylua",
				-- JAVA
				"jdtls",
				"java-test",
				"java-debug-adapter",
				"google-java-format",
				"vscode-spring-boot-tools",
				-- WEB
				"superhtml",
				"htmx-lsp",
				"css-lsp",
				"css-variables-language-server",
				-- JS & TS
				"vtsls",
				"tsgo",
				"oxlint",
				"oxfmt",
				"vue-language-server",
				-- RUST
				-- "rust-analyzer",
				-- "rustfmt",
			},
		},
	},
}
