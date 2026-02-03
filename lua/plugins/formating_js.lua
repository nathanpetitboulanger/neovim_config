return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" }, -- Ajoute cette ligne pour les .jsx
      typescriptreact = { "prettier" }, -- Ajoute cette ligne pour les .tsx
    },
    format_on_save = {
      timeout_ms = 500,
      -- C'est ici que ça se joue :
      -- Si true, il utilise l'LSP si prettier n'est pas dispo.
      -- Si tu veux VRAIMENT prettier, tu peux mettre false ici.
      lsp_fallback = false,
    },
  },
}
