require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("i", "<C-d>", "<esc>yypi", { desc = "Duplicate line"})
map("i", "<C-x>", "<esc>ddi", { desc = "Delete line"})
map("i", "<C-z>", "<esc>ui", { desc = "Undo latest change"})

-- Debugging
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <cr>", { desc = "Debug Breakpoint" })
map(
  "n",
  "<leader>dus",
  function ()
    local widgets = require("dap.ui.widgets");
    local sidebar = widgets.sidebar(widgets.scopes);
    sidebar.open();
  end,
  { desc = "Debug Open Sidebar"}
)

-- Telescope
map("n", "<C-p>", "<cmd> Telescope <cr>", { desc = "Telescope: Open"})

-- Code Runner
-- Open Compiler
vim.api.nvim_set_keymap('n', '<leader>cr', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
vim.api.nvim_set_keymap('n', '<S-F6>',
     "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
  .. "<cmd>CompilerRedo<cr>",
 { noremap = true, silent = true })

map("n", "<C-cr>",
  function ()
    local option = ""
    local current_filetype = vim.bo.filetype
    local language = require('compiler.utils').require_language(current_filetype)
    if not language then language = require("compiler.languages.make") end
    if current_filetype == "rust" then option = "option7"
    else vim.notify(current_filetype) end
    language.action(option)
  end,
  { desc = "Run program"}
)

-- Toggle compiler results
vim.api.nvim_set_keymap('n', '<S-F7>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

if vim.lsp.inlay_hint then
  map("n", "<leader>L",
  function(bufnr)
    if vim.lsp.inlay_hint.is_enabled() then vim.lsp.inlay_hint.enable(false, { bufnr })
    else vim.lsp.inlay_hint.enable(true, { bufnr }) end
  end,
  { desc = "Toggle inlay hints"})
end
