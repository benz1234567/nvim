local lsp = { }

vim.lsp.start({
  name = 'lua-language-server',
  cmd = {'/home/benny/Desktop/luals/lua-language-server'},
  root_dir = vim.fn.getcwd(),
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*.lua',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.buf_attach_client(bufnr, 1)
  end,
})

return lsp
