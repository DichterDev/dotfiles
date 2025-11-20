return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = "LspAttach",
    opts = {
      name = {
        ".venv",
        "venv",
        ".virtualenv",
      },
      auto_select = {
        "basedpyright",
        "ruff",
      },
    },
    config = function(_, opts)
      require("venv-selector").setup(opts)
    end
  },
}
