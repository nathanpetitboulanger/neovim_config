return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      html = { "prettier" },
      sql = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        args = { "format", "--dialect", "duckdb", "-" },
      },
    },
  },
}
