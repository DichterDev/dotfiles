local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. project_name
local mason = vim.fn.stdpath("data") .. "/mason"

local bundels = {
  vim.fn.glob(mason .. "/share/vscode-spring-boot-tools/jdtls/*-extension.jar", true),
  vim.fn.glob(mason .. "/share/java-test/*.jar", true),
}

local lombok = vim.fn.glob(mason .. "/share/jdtls/lombok.jar", true)

---@type vim.lsp.Config
return {
  cmd = { "jdtls", "--data", workspace_dir, "--jvm-arg=-javaagent:" .. lombok },
  settings = {
    java = {
      format = {
        enabled = true,
      },
    },
    spring = {
      boot = {
        ls = {
          enabled = true,
        },
      },
      validation = {
        enabled = true,
      },
      project = {
        detection = {
          enabled = true,
        },
      },
    },
  },
  init_options = {
    bundles = bundels
  }
}
