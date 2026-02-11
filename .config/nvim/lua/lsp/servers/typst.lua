---@type vim.lsp.Config
return {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {
    exportPdf = "never",
    formatterMode = "typstyle",
  }
}
