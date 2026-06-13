vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = false
opt.wrap = false
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.colorcolumn = "80"

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 400

opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.isfname:append("@-@")
