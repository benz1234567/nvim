-- Plugins from pm plugin manager
vim.cmd.source("/home/benny/.config/nvim/pm.vim")

-- Allow you to access any file in any subdirectory with :find
vim.o.path = '.,**,'


-- Status bar settings, shows the current file all the way to the right
-- vim.api.nvim_set_hl(0, 'blue', { fg = '#ffffff', bg = '#16243b' })
-- vim.api.nvim_set_hl(0, 'black', { fg = '#ffffff', bg = '#000000' })
-- vim.api.nvim_set_hl(0, 'default', { fg = '#e0e2ea', bg = '#14161b' })
-- vim.o.statusline = "%#default#%=%f  "

-- Removes the status bar:
vim.opt.laststatus = 0

-- Set colorscheme
--vim.cmd('colorscheme wildcharm')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
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
vim.opt.cursorline = true

-- Keeps cursor in center of screen
vim.opt.scrolloff = 100

-- Escape removes search higlighting
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Flash highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keymaps:
--
-- Leader+y yanks to system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>f', '<cmd>FZF<CR>')

-- Autocommand to copy vim-be-better to the plugin directory
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "/home/benny/Desktop/vim-be-better/**",
    callback = function()
        -- Schedule the command to run asynchronously
        vim.schedule(function()
            vim.fn.system("sudo cp -r $HOME/Desktop/vim-be-better $HOME/.local/share/nvim/site/pack/plugins/start")
        end)
    end
})
