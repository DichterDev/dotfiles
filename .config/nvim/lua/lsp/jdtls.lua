local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. project_name

---@type vim.lsp.Config
return {
  cmd = { "jdtls", "--data", workspace_dir },
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
    bundles = {
      vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/spring-boot-tools/extension/jars/*-extension.jar", true)
    }
  }
}
