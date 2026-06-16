local sql_ft = { "sql", "mysql", "plsql" }

-- Keep Neovim's built-in SQL omni-completion from fighting blink.cmp.
vim.g.omni_sql_default_compl_type = "syntax"
vim.g.loaded_sql_completion = true

local function duckdb_url(path)
  if path:match("^duckdb:") then
    return path
  end
  return "duckdb:" .. path
end

local function setup_duckdb_connections()
  local main_db = duckdb_url("/home/nathan/fltrd/data-pipeline/data/fltrd.duckdb")
  local test_db = duckdb_url(vim.env.DUCKDB_PATH or "/home/nathan/fltrd/data-pipeline/data/test.duckdb")

  -- Used by vim-dadbod-completion when editing a normal .sql buffer.
  -- Default to data/test.duckdb because that is the exploratory DB with the
  -- retailer_* tables. Override per launch with DUCKDB_PATH=/path/to/db.duckdb.
  vim.g.db = vim.g.db or test_db

  -- Used by :DBUI.
  vim.g.dbs = vim.tbl_extend("force", vim.g.dbs or {}, {
    fltrd = main_db,
    fltrd_test = test_db,
  })
end

setup_duckdb_connections()

return {
  {
    "tpope/vim-dadbod",
    cmd = "DB",
    init = setup_duckdb_connections,
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = { "tpope/vim-dadbod" },
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
    },
    init = function()
      setup_duckdb_connections()

      local data_path = vim.fn.stdpath("data")
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true
      vim.g.db_ui_execute_on_save = false
    end,
  },

  {
    "kristijanhusak/vim-dadbod-completion",
    ft = sql_ft,
    dependencies = { "tpope/vim-dadbod" },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "kristijanhusak/vim-dadbod-completion" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.per_filetype = opts.sources.per_filetype or {}

      opts.sources.providers.dadbod = {
        name = "Dadbod",
        module = "vim_dadbod_completion.blink",
        score_offset = 100,
      }

      opts.sources.providers.duckdb = {
        name = "DuckDB",
        module = "duckdb_completion.blink",
        score_offset = 110,
      }

      for _, ft in ipairs(sql_ft) do
        -- Use the custom DuckDB source for SQL buffers. It is context-aware:
        -- FROM/JOIN completes tables, SELECT/WHERE completes columns.
        opts.sources.per_filetype[ft] = { inherit_defaults = true, "duckdb" }
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "sql") then
        table.insert(opts.ensure_installed, "sql")
      end
    end,
  },
}
