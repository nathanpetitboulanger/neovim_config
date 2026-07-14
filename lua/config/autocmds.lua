-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local sql_filetypes = { "sql", "mysql", "plsql" }
local sql_group = vim.api.nvim_create_augroup("DisableSqlFormatOnSave", { clear = true })

-- sqlfluff startup is slow enough to make :w feel laggy. Keep SQL formatting
-- available manually with :LazyFormat, but don't run it automatically on save.
vim.api.nvim_create_autocmd("FileType", {
  group = sql_group,
  pattern = sql_filetypes,
  callback = function(event)
    vim.b[event.buf].autoformat = false
  end,
})
