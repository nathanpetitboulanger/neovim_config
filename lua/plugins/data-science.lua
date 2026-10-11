return {
  -- 1. Support de Quarto (.qmd)
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown", "python" },
    config = function()
      require("quarto").setup({
        lsp_features = {
          languages = { "python", "r", "julia" },
          chunks = "all",
          diagnostics = { enabled = true },
          completion = { enabled = true },
        },
      })
    end,
  },

  -- 2. Molten : Pour l'exécution interactive du code (Jupyter)
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- Utilise la version stable
    build = ":UpdateRemotePlugins",
    init = function()
      -- Options pour l'affichage des résultats
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false -- N'ouvre pas la fenêtre de résultat tout seul
    end,
  },

  -- 3. Image.nvim : Pour afficher tes graphiques Matplotlib/Seaborn
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- IMPORTANT: Si tu n'utilises pas Kitty, change par "ueberzug"
      max_height_window_percentage = 50,
      hierarchies = { "quarto", "markdown" },
      window_overlap_clear_enabled = true,
    },
  },

  -- 4. vim-slime : Envoyer du code vers un REPL ouvert dans un terminal Neovim (cf. <leader>zi)
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
      vim.keymap.set("n", "<leader>pw", "<Plug>SlimeMotionSendiw", { remap = true, desc = "Envoyer le mot au REPL" })
    end,
  },
}
