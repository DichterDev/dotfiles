---@type vim.lsp.Config
return {
  cmd = { "jdtls" },
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
