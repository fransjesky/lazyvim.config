-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Suppress Treesitter highlight group linking messages
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Temporarily reduce log level to suppress info messages during startup
    local original_level = vim.log.levels.INFO
    vim.log.levels.INFO = vim.log.levels.WARN

    -- Restore original log level after startup
    vim.defer_fn(function()
      vim.log.levels.INFO = original_level
    end, 1000)
  end,
})
