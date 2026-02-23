-- Basic UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.cmdheight = 1
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.syntax = "on"

-- Wrapping
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
-- vim.o.showbreak = "↳"

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
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.conceallevel = 0
-- vim.o.clipboard = "unnamedplus"

-- Performance
vim.o.lazyredraw = false
vim.o.undofile = false
vim.o.syntax = "on"

-- Advanced UI
vim.o.winborder = "rounded"

-- SHELL
vim.o.sh = "/bin/fish"
