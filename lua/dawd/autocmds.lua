local autocmds = { }

-- Flash highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Autocommand to copy vim-be-better to the plugin directory
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "/home/benny/Desktop/nvplugins/**",
    callback = function()
        -- Schedule the command to run asynchronously
        vim.schedule(function()
            vim.fn.system("sudo cp -r $HOME/Desktop/nvplugins/* $HOME/.local/share/nvim/site/pack/plugins/start")
        end)
    end
})

-- Autocommand to copy vim-be-better to the plugin directory
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      local targetdir = "/home/benny/Zettelkasten"
      if vim.fn.getcwd():sub(1, #targetdir) == targetdir then
        require("dawd.obsidian")
      else
        package.loaded["dawd.obsidian"] = nil
      end
    end
})

return autocmds
