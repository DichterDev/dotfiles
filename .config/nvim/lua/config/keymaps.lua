Map = vim.keymap.set

-- Normal Mode
Map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
Map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Remaps
Map({ "n", "x", "o" }, "ö", "[", { desc = "Left bracket [", remap = true })
Map({ "n", "x", "o" }, "ä", "]", { desc = "Right bracket ]", remap = true })
Map({ "n", "x", "o" }, "ü", "\\", { desc = "Backslash \\", remap = true })

-- Select all
Map("n", "<C-a>", "ggVG", { desc = "Visual select all" })

-- Navigation
Map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
Map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
Map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
Map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- Resizing windows
Map("n", "<leader>h", "<C-w><", { desc = "Decrease window width" })
Map("n", "<leader>l", "<C-w>>", { desc = "Increase window width" })
Map("n", "<leader>j", "<C-w>+", { desc = "Increase window height" })
Map("n", "<leader>k", "<C-w>-", { desc = "Decrease window height" })

-- Clear search highlights
Map("n", "<leader>cs", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Yanking
Map({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to clipboard" })
Map("n", "<leader>yy", '"+yy', { desc = "[yy]ank to clipboard" })
Map("n", "<leader>Y", '"+y_', { desc = "[Y]ank to clipboard" })

-- Pasting
Map({ "n", "v" }, "<leader>p", '"+p"', { desc = "[p]aste from clipboard" })
Map({ "n", "v" }, "<leader>P", '"+P"', { desc = "[P]aste from clipboard" })

-- Buffer navigation
Map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
Map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
Map("n", "<leader>bd", ":bd<CR>", { desc = "Delete current buffer" })

-- Save and Quit
Map("n", "<leader>w", ":w<CR>", { desc = "Save" })
Map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
Map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all without saving" })

-- Visual mode keymaps
-- Stay in indent mode
Map("v", "<", "<gv", { desc = "Unindent (Visual)" })
Map("v", ">", ">gv", { desc = "Indent (Visual)" })

-- LSP
Map("n", "gd", vim.lsp.buf.definition, { desc = "[g]o [d]efinition" })
Map("n", "gr", vim.lsp.buf.references, { desc = "[g]o [r]efrences" })
Map("n", "gD", vim.lsp.buf.declaration, { desc = "[g]o [D]eclarations" })
Map("n", "gi", vim.lsp.buf.implementation, { desc = "[g]o [i]mplementation" })
Map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
Map("n", "<C-.>", vim.lsp.buf.code_action, { desc = "[c]ode [a]ctions" })
Map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
Map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "[f]ormat buffer" })

-- Diagnostics
Map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnostics" })


-- Terminal
Map("n", "<leader>vt", ":vsplit | term<CR>", { desc = "[v]ertical [t]erminal" })
Map("n", "<leader>ht", ":vsplit | term<CR>", { desc = "[h]orizontal [t]erminal" })

-- Quickfix List
Map("n", "[q", ":cprev<CR>", { desc = "Previous Quickfix item" })
Map("n", "]q", ":cnext<CR>", { desc = "Next Quickfix item" })
Map("n", "[Q", ":cfirst<CR>", { desc = "First Quickfix item" })
Map("n", "]Q", ":clast<CR>", { desc = "Last Quickfix item" })

Map("n", "<leader>qo", ":copen<CR>", { desc = "[q]uickfix [o]pen" })
Map("n", "<leader>qc", ":cclose<CR>", { desc = "[q]uickfix [c]lose" })
Map("n", "<leader>qt", function()
  local exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then exists = true end
  end
  if exists then vim.cmd("cclose") else vim.cmd("copen") end
end, { desc = "[q]uickfix [t]oggle" })
