return {
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim" -- Utilise le terminal intégré de Neovim
    end,
    config = function()
      -- Raccourci pour envoyer la sélection ou le paragraphe
      vim.keymap.set("x", "<leader>ps", "<Plug>SlimeRegionSend", { desc = "Envoyer la sélection au REPL" })
      vim.keymap.set("n", "<leader>ps", "<Plug>SlimeParagraphSend", { desc = "Envoyer le paragraphe au REPL" })
      vim.keymap.set("n", "<leader>pa", ":%SlimeSend<CR>", { desc = "Envoyer tout le fichier au REPL" })
    end,
  },
}
