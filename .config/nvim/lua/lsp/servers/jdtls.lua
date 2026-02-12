local data = vim.fn.stdpath("data")
local config = vim.fn.stdpath("config")
local glob = vim.fn.glob

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

local lombok = glob(mason .. "/share/jdtls/lombok.jar", true)

local bundles = {}

local springboot = require("spring_boot")
local microprofile = require("microprofile")
local quarkus = require("quarkus")

vim.list_extend(bundles, springboot.java_extensions())
vim.list_extend(bundles, microprofile.java_extensions())
vim.list_extend(bundles, quarkus.java_extensions())

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
    bundles = bundles,
  },
  on_init = function(_, _)
    springboot.init_lsp_commands()
    require("microprofile.bind").try_bind_microprofile_all_request()
    require("quarkus.bind").try_bind_qute_all_request()
  end
}
