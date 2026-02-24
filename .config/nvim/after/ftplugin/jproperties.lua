local utils = require("core.utils.java")

local root_markers = {
	"build.xml",
	"mvnw",
	"pom.xml",
	"gradlew",
	"settings.gradle",
	"settings.gradle.kts",
	"build.gradle",
	"build.gradle.kts",
}

local root_dir = utils.get_root_dir(root_markers)
utils.detect_framework(root_dir)

if vim.g.springboot then
	---@type vim.lsp.Config
	local config = require("spring_boot.launch").update_ls_config({
		server = {
			capabilities = require("lsp.defaults").capabilities({}),
			on_init = function(client, _)
				client.server_capabilities.documentHighlightProvider = false
			end,
		},
		autocmd = false,
	})

	vim.lsp.start(config)
end

if vim.g.quarkus then
	---@type vim.lsp.Config
	local quarkus = require("quarkus.launch").lsp_config({
		root_dir = root_dir,
		capabilities = require("lsp.defaults").capabilities({}),
	}) or {}

	---@type vim.lsp.Config
	local microprofile = require("microprofile.launch").lsp_config({
		root_dir = root_dir,
		capabilities = require("lsp.defaults").capabilities({}),
	}) or {}

	vim.lsp.start(quarkus)
	vim.lsp.start(microprofile)
end

utils.reset_framework()
