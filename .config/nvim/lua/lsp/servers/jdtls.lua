---@type Server
local M = {}

local data = vim.fn.stdpath("data")
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
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = data .. "/jdtls/workspace/" .. project_name

local lombok = vim.fn.glob(mason .. "/share/jdtls/lombok.jar", true)

local bundles = {}

vim.list_extend(bundles, vim.fn.glob(mason .. "/share/vscode-spring-boot-tools/jdtls/*.jar", true, true))
vim.list_extend(bundles, vim.fn.glob(mason .. "/share/java-test/*.jar", true, true))

M.config = {
  cmd = { "jdtls", "--data", workspace_dir, "--jvm-arg=-javaagent:" .. lombok, "--jvm-arg=-Xmx2g" },
  root_markers = root_markers,
  filetypes = { "java", },
  settings = {
    java = { format = { enabled = true, }, },
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
  }
}

return M
