local data = vim.fn.stdpath("data")
local cache = vim.fn.stdpath("cache")
local mason = data .. "/mason"

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

local root_dir = vim.fs.root(0, root_markers) or vim.fn.getcwd()

---@param dir string
---@return string
local function get_workspace(dir)
	local root_hash = vim.fn.sha256(dir):sub(1, 8)
	local project_name = vim.fn.fnamemodify(dir, ":p:h:t")
	local workspace_name = project_name .. "-" .. root_hash
	local workspace_dir = cache .. "/jdtls/workspace/" .. workspace_name

	if vim.fn.isdirectory(workspace_dir) == 0 then
		vim.fn.mkdir(workspace_dir, "p")
	end

	vim.notify("Workspace: " .. workspace_name, vim.log.levels.INFO)

	return workspace_dir
end

---@return string
local function get_lombok()
	return vim.fn.glob(mason .. "/share/jdtls/lombok.jar", true)
end

---@return table<string>
local function get_java_test()
	return vim.fn.glob(mason .. "/share/java-test/*.jar", true, true)
end

---@return table<string>
local function get_java_debug_adapter()
	return vim.fn.glob(mason .. "/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar", true, true)
end

---@return table<string>
local function get_spring_boot()
	return vim.fn.glob(mason .. "/share/vscode-spring-boot-tools/jdtls/*.jar", true, true)
end

local bundles = {}

-- vim.list_extend(bundles, get_java_test())
-- vim.list_extend(bundles, get_java_debug_adapter())
-- vim.list_extend(bundles, get_spring_boot())

---@type vim.lsp.Config
local config = {
	cmd = {
		"jdtls",
		"-data",
		get_workspace(root_dir),
		"--jvm-arg=-javaagent:" .. get_lombok(),
		"--jvm-arg=-Xms512m",
		"--jvm-arg=-Xmx2g",
		"--jvm-arg=-XX:+UseG1GC",
		"--jvm-arg=-XX:TieredStopAtLevel=1",
	},
	root_dir = root_dir,
	---@type lspconfig.settings.jdtls
	settings = {
		java = {
			-- maxConcurrentBuilds = 4,
			autobuild = { enabled = true },
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			configuration = {
				updateBuildConfiguration = "automatic",
			},
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath("config") .. "/format/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			completion = {
				importOrder = {
					"com",
					"org",
					"at",
					"java",
					"javax",
					"jakarta",
					"",
					"#",
				},
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
			import = {
				gradle = {
					annotationProcessing = { enabled = true },
				},
				exclusions = {
					"**/build/**",
					"**/.gradle/**",
					"**/target/**",
					"**/.git/**",
					"**/node_modules/**",
					"**/.metadata/**",
					"**/archived/**",
				},
			},
		},
		redhat = {
			telemetry = { enabled = false },
		},
	},
	-- init_options = {
	-- 	-- bundles = bundles,
	-- },
}

require("util").lsp.setup("jdtls", config)
