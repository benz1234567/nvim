local maps = { }

-- Keymaps:
--
-- Leader+y yanks to system clipboard, leader+p pastes from system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p')

vim.keymap.set('n', '<leader>f', '<cmd>FZF<CR>')
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR><c-w><c-h>')
vim.keymap.set('n', '-', '<cmd>Oil<CR>')

-- Toggle LSP
vim.keymap.set('n', '<leader>l', function()
  if package.loaded["dawd.zero"] then
    package.loaded["dawd.zero"] = nil
    vim.cmd("LspStop")
  else
    require("dawd.zero")
    vim.cmd("LspStart")
  end
end)

-- Escape removes search higlighting
--vim.opt.hlsearch = true
--vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

return maps
