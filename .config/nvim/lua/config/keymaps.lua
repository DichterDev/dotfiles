local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Ex
map("n", "<leader>x", ":Ex<CR>", { desc = "Ex" })

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Visual select all" })

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

-- Yanking
map({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "[yy]ank to clipboard" })
map("n", "<leader>Y", '"+y_', { desc = "[Y]ank to clipboard" })

-- Pasting
map({ "n", "v" }, "<leader>p", '"+p"', { desc = "[p]aste from clipboard" })
map({ "n", "v" }, "<leader>P", '"+P"', { desc = "[P]aste from clipboard" })

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

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "[g]o [d]efinition" })
map("n", "gr", vim.lsp.buf.references, { desc = "[g]o [r]efrences" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "[g]o [D]eclarations" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "[g]o [i]mplementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<C-.>", vim.lsp.buf.code_action, { desc = "[c]ode [a]ctions" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "[f]ormat buffer" })

-- Diagnostics
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnostics" })


-- Terminal
map("n", "<leader>vt", ":vsplit | term<CR>", { desc = "[v]ertical [t]erminal" })
map("n", "<leader>ht", ":vsplit | term<CR>", { desc = "[h]orizontal [t]erminal" })
