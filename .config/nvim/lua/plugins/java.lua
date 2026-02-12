---@type LazySpec
return {
  { "mfussenegger/nvim-jdtls" },
  {
    "JavaHello/spring-boot.nvim",
    dependencies = {
      "mfussenegger/nvim-jdtls"
    },
    opts = {}
  },
  {
    "JavaHello/quarkus.nvim",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "JavaHello/microprofile.nvim"
    },
    opts = {}
  }

}
