--Plugins from pm plugin manager
local plugins = {
-- My plugins:
'https://github.com/benz1234567/vim-be-better',
'https://github.com/benz1234567/nvtt',

-- LSP:
'https://github.com/VonHeikemen/lsp-zero.nvim',
'https://github.com/neovim/nvim-lspconfig',
'https://github.com/williamboman/mason.nvim',
'https://github.com/williamboman/mason-lspconfig.nvim',
'https://github.com/hrsh7th/cmp-nvim-lsp',
'https://github.com/hrsh7th/nvim-cmp',

-- Other:
'https://github.com/nvim-treesitter/nvim-treesitter',
'https://github.com/nvim-treesitter/nvim-treesitter-context',
'https://github.com/junegunn/fzf',
'https://github.com/mbbill/undotree',
'https://github.com/stevearc/oil.nvim',
}

vim.g.plugins = plugins

vim.g.undofile = ""
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("dawd.maps")
require("dawd.autocmds")
require("dawd.treesitter")
require("oil").setup()
--require("dawd.zero")
--require("dawd.lsp")

vim.o.mouse = ""

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
