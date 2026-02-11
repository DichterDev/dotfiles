return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
      },
      checkOnSave = true,
      procMacro = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        experimental = { enable = true },
      },
      inlayHints = {
        enable = true,
        bindingModeHints = { enable = true },
        closingBraceHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "skip_trivial" },
        reborrowHints = { enable = "always" },
        typeHints = { enable = true },
        parameterHints = { enable = true },
        chainingHints = { enable = true },
      },
    },
  }
}
