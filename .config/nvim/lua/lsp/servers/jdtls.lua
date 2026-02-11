local data = vim.fn.stdpath("data")
local config = vim.fn.stdpath("config")
local glob = vim.fn.glob

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
local mason = data .. "/mason"
local extras = config .. "/lua/lsp/extras/java"

local bundels = {
  glob(mason .. "/share/vscode-spring-boot-tools/jdtls/*-extension.jar", true),
  glob(mason .. "/share/java-test/*.jar", true),
  glob(extras .. "/*/*.jar", true)
}

local lombok = glob(mason .. "/share/jdtls/lombok.jar", true)

---@type vim.lsp.Config
return {
  cmd = { "jdtls", "--data", workspace_dir, "--jvm-arg=-javaagent:" .. lombok },
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
    bundles = bundels,
  }
}
