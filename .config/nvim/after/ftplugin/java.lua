local utils = require("core.utils").java

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

local capabilities = require("lsp.defaults").capabilities({})

local root_dir = utils.get_root_dir(root_markers)
utils.detect_framework(root_dir)

local bundles = {}

vim.list_extend(bundles, utils.extensions.get_java_test())
vim.list_extend(bundles, utils.extensions.get_java_debug_adapter())

if vim.g.springboot then
	vim.list_extend(bundles, utils.extensions.get_spring_boot())
end

if vim.g.quarkus then
	vim.list_extend(bundles, require("quarkus").java_extensions())
	vim.list_extend(bundles, require("microprofile").java_extensions())
end

---@type vim.lsp.Config
local jdtls = {
	cmd = {
		"jdtls",
		"-data",
		utils.get_workspace_dir(root_dir),
		"--jvm-arg=-javaagent:" .. utils.get_lombok(),
		"--jvm-arg=-Xmx2g",
	},
	capabilities = capabilities,
	-- root_markers = root_markers,
	root_dir = root_dir,
	on_init = function(client, _)
		if vim.g.quarkus then
			require("quarkus.bind").try_bind_qute_all_request()
			require("microprofile.bind").try_bind_microprofile_all_request()
		end
	end,
	settings = {
		java = {
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath("config") .. "/lang-servers/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			completion = {
				favoriteStaticMembers = {
					"io.crate.testing.Asserts.assertThat",
					"org.assertj.core.api.Assertions.assertThat",
					"org.assertj.core.api.Assertions.assertThatThrownBy",
					"org.assertj.core.api.Assertions.catchThrowable",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.mock",
					"org.mockito.Mockito.when",
					"jakarta.ws.rs.core.Response.*",
					"io.quarkus.test.junit.QuarkusTest.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
		},
	},
	init_options = {
		bundles = bundles,
	},
}

require("jdtls").start_or_attach(jdtls)

if vim.g.quarkus then
	---@type vim.lsp.Config
	local quarkus = require("quarkus.launch").lsp_config({ capabilities = capabilities }) or {}
	---@type vim.lsp.Config
	local microprofile = require("microprofile.launch").lsp_config({ capabilities = capabilities }) or {}

	vim.lsp.start(quarkus)
	vim.lsp.start(microprofile)
end

utils.reset_framework()
