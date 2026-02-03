-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.g.python3_host_prog = "/usr/bin/python3" -- Remplace par le chemin de ton 'which python3'
vim.opt.spell = true -- Active la vérification orthographique
vim.opt.spelllang = { "fr", "en" } -- Définit le français comme langue par défaut
