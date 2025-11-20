local function get_venv_path()
  local cwd = vim.fn.expand("%:p:h")
  local venv = cwd .. "/.venv"
  local python = venv .. "/bin/python"

  return { venv = venv, python = python }
end

---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    basedpyright = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic", -- standard, strict, all, off, basic
      },
    },
    python = {
      -- pythonPath = get_venv_path().python,
      -- venvPath = get_venv_path().venv
    }
  },
}
