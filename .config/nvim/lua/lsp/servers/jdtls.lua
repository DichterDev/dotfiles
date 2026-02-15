---@type Server
local M = {}

local utils = require("core.utils")
local defaults = require("lsp.defaults")

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

-- vim.tbl_extend("keep", root_markers, defaults.root_markers)


local bundles = {}

-- vim.list_extend(bundles, vim.fn.glob(mason .. "/share/vscode-spring-boot-tools/jdtls/*.jar", true, true))
vim.list_extend(bundles, vim.fn.glob(mason .. "/share/java-test/*.jar", true, true))
vim.list_extend(bundles,
  vim.fn.glob(mason .. "/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar", true, true))

M.ignored = true

M.config = {
  name = "jdtls",
  cmd = {
  },
  root_markers = root_markers,
  capabilities = defaults.capabilities({}),
  settings = {
    java = {
      format = { enabled = true, },
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
    spring = {
      boot = { ls = { enabled = true, }, },
      validation = { enabled = true, },
      project = { detection = { enabled = true, }, },
    },
    quarkus = {
      tools = {
        completion = { enabled = true },
        validation = { enabled = true }
      }
    },
  },
  init_options = {
    bundles = bundles,
  },
}

return M
