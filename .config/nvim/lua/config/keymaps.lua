local map = vim.keymap.set

-- Normal mode keymaps
-- Exit insert mode quicker
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Ex
map("n", "<leader>x", ":Ex<CR>", { desc = "Ex" })

-- Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- Resizing windows
map("n", "<leader>h", "<C-w><", { desc = "Decrease window width" })
map("n", "<leader>l", "<C-w>>", { desc = "Increase window width" })
map("n", "<leader>j", "<C-w>+", { desc = "Increase window height" })
map("n", "<leader>k", "<C-w>-", { desc = "Decrease window height" })

-- Clear search highlights
map("n", "<leader>cs", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bd<CR>", { desc = "Delete current buffer" })

-- Save and Quit
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all without saving" })

-- Visual mode keymaps
-- Stay in indent mode
map("v", "<", "<gv", { desc = "Unindent (Visual)" })
map("v", ">", ">gv", { desc = "Indent (Visual)" })

-- LSP keymaps (will be overridden or supplemented by LSP config)
-- These are just placeholders
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format buffer" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
