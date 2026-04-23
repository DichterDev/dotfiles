-- Wrapping
vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true
-- vim.o.showbreak = "↳"

-- Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true

-- Hidden characters
vim.o.list = true
vim.o.listchars = "trail:·,tab:»·,nbsp:+"

-- Scrolloff
vim.o.scrolloff = 12
vim.o.sidescrolloff = 8

-- FILES
vim.o.undofile = true
vim.o.swapfile = false

-- Neovim specific
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.conceallevel = 0
vim.o.wildmode = "longest:full,full"
vim.o.virtualedit = "block"

-- SHELL
vim.o.sh = "/bin/fish"
