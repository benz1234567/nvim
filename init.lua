--Plugins from pm plugin manager
vim.cmd.source("/home/benny/.config/nvim/pm.vim")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("dawd.maps")
require("dawd.autocmds")
require("dawd.treesitter")
--require("dawd.zero")
--require("dawd.lsp")

-- Allow you to access any file in any subdirectory with :find
vim.o.path = '.,**,'

-- Removes the status bar:
vim.opt.laststatus = 0

--vim.cmd('colorscheme wildcharm')

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Shows trailing space as ·
vim.opt.list = true
vim.opt.listchars = { trail = '·', tab = '  ' }

-- Makes tabs two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- Shows substitution commands as what they'll look like live
vim.opt.inccommand = 'split'
-- Highlights incrementally as I search
vim.opt.incsearch = true
-- Doesn't highlight search results after I press enter
vim.opt.hlsearch = false

vim.opt.cursorline = true

-- Keeps cursor in center of screen
vim.opt.scrolloff = 100
