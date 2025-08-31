
-- Basic UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.cmdheight = 1
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.termguicolors = true

-- Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- Searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- Neovim specific
vim.o.updatetime = 300 -- Faster update for CursorHold
vim.o.timeoutlen = 500 -- Decrease mapped sequence timeout
vim.o.conceallevel = 0 -- Don't conceal by default (useful for markdown)

-- Performance
vim.o.lazyredraw = true
vim.o.undofile = false
vim.o.syntax = "on"

vim.o.winborder = "rounded"
