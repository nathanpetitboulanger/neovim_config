-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Reload files changed outside Neovim more eagerly than LazyVim's default
-- (which only checks on FocusGained / terminal close).
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  group = vim.api.nvim_create_augroup("AutoReloadChangedFiles", { clear = true }),
  command = "if mode() != 'c' | checktime | endif",
})

local function harmonize_neotree_git_colors()
  local function use_theme_color(group, source)
    local current = vim.api.nvim_get_hl(0, { name = group, link = false })
    -- Neo-tree uses #ff8700 when a colorscheme does not define these groups.
    if current.fg and current.fg ~= 0xff8700 then
      return
    end

    vim.api.nvim_set_hl(0, group, { link = source })
  end

  use_theme_color("NeoTreeGitConflict", "DiagnosticError")
  use_theme_color("NeoTreeGitUnstaged", "DiagnosticWarn")
  use_theme_color("NeoTreeGitUntracked", "DiagnosticWarn")
end

local neotree_theme_group = vim.api.nvim_create_augroup("HarmonizeNeoTreeGitColors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = neotree_theme_group,
  callback = harmonize_neotree_git_colors,
})
harmonize_neotree_git_colors()

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
