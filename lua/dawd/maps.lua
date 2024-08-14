local maps = { }

-- Keymaps:
--
-- Leader+y yanks to system clipboard, leader+p pastes from system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p')

vim.keymap.set('n', '<leader>f', '<cmd>FZF<CR>')

-- Escape removes search higlighting
--vim.opt.hlsearch = true
--vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

return maps
