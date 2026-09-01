---@type vim.lsp.Config
return {
	cmd = { "qml-language-server" },
	filetypes = { "qml" },
	root_markers = { { "qmldir", "shell.qml" }, ".git" },
}
