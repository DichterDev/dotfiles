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

vim.list_extend(bundles, get_java_test())
vim.list_extend(bundles, get_java_debug_adapter())
vim.list_extend(bundles, get_spring_boot())

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities

local cmd = {
	"jdtls",
	"--java-executable",
	"/usr/lib/jvm/java-25-openjdk/bin/java",
	"-configuration",
	get_workspace(root_dir) .. "/config",
	"-data",
	get_workspace(root_dir),
	-- "--jvm-arg=-Xms1g",
	-- "--jvm-arg=-Xmx2g",
	-- "--jvm-arg=-XX:+UseParallelGC",
	-- "--jvm-arg=-XX:+UseTransparentHugePages",
	-- "--jvm-arg=-XX:GCTimeRatio=4",
	-- "--jvm-arg=-XX:TieredStopAtLevel=1",
	-- "--jvm-arg=-Dsun.zip.disableMemoryMapping=true",
}

local lombok_path = get_lombok()
if lombok_path ~= "" then
	-- table.insert(cmd, "--jvm-arg=-javaagent:" .. lombok_path)
end

---@type vim.lsp.Config
local config = {
	cmd = cmd,
	root_dir = root_dir,
	capabilities = require("blink-cmp").get_lsp_capabilities(),
	handlers = {
		["language/status"] = function() end,
	},
	---@type lspconfig.settings.jdtls
	settings = {
		java = {
			-- maxConcurrentBuilds = 4,
			autobuild = { enabled = false },
			referencesCodeLens = { enabled = false },
			implementationCodeLens = "none",
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath("config") .. "/format/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			completion = {
				guessMethodArguments = "off",
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
					"**/.quarkus/**",
					"**/.ziggy/**",
				},
			},
		},
		redhat = {
			telemetry = { enabled = false },
		},
	},
	init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	},
	on_attach = function()
		require("jdtls").setup_dap()
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
}

require("jdtls").start_or_attach(config)
