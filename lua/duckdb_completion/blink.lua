local M = {}

local cache = {}

local CompletionItemKind = vim.lsp.protocol.CompletionItemKind

local function get_db_path()
  local db = vim.b.db or vim.t.db or vim.w.db or vim.g.db or vim.env.DATABASE_URL
  if type(db) ~= "string" or db == "" then
    return nil
  end
  if not db:match("^duckdb:") then
    return nil
  end
  local path = db:gsub("^duckdb:", "")
  path = path:gsub("%?.*$", "")
  if path == "" or path == ":memory:" then
    return nil
  end
  return path, db
end

local function run_duckdb(path, query)
  return vim.fn.systemlist({ "duckdb", "-readonly", path, "-csv", "-noheader", "-c", query })
end

local function load_schema()
  local path, db = get_db_path()
  if not path then
    return nil
  end

  local mtime = vim.fn.getftime(path)
  local cached = cache[db]
  if cached and cached.mtime == mtime then
    return cached
  end

  local schema = {
    mtime = mtime,
    tables = {},
    columns = {},
    columns_by_table = {},
  }

  local table_rows = run_duckdb(
    path,
    "select table_name from information_schema.tables where table_schema not in ('information_schema','pg_catalog') order by table_name"
  )
  for _, row in ipairs(table_rows) do
    if row ~= "" then
      table.insert(schema.tables, row)
      schema.columns_by_table[row] = {}
    end
  end

  local column_rows = run_duckdb(
    path,
    "select table_name, column_name from information_schema.columns where table_schema not in ('information_schema','pg_catalog') order by table_name, ordinal_position"
  )
  for _, row in ipairs(column_rows) do
    local table_name, column_name = row:match('^"?([^",]+)"?,"?([^",]+)"?$')
    if table_name and column_name then
      schema.columns[column_name] = true
      schema.columns_by_table[table_name] = schema.columns_by_table[table_name] or {}
      table.insert(schema.columns_by_table[table_name], column_name)
    end
  end

  cache[db] = schema
  return schema
end

local function current_word(ctx)
  local cursor_col = ctx.cursor and ctx.cursor[2] or vim.api.nvim_win_get_cursor(0)[2]
  local line = ctx.line or vim.api.nvim_get_current_line()
  local word_start = cursor_col + 1

  while word_start > 1 do
    local char = line:sub(word_start - 1, word_start - 1)
    if char:match("[%s%.,%(%)=]") then
      break
    end
    word_start = word_start - 1
  end

  return line:sub(word_start, cursor_col)
end

local function buffer_sql_text()
  return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
end

local function text_before_cursor(ctx)
  local row = ctx.cursor and ctx.cursor[1] or vim.api.nvim_win_get_cursor(0)[1]
  local col = ctx.cursor and ctx.cursor[2] or vim.api.nvim_win_get_cursor(0)[2]
  local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)
  if #lines == 0 then
    return ""
  end
  lines[#lines] = (ctx.line or lines[#lines]):sub(1, col)
  return table.concat(lines, "\n")
end

local function is_table_context(ctx)
  local before = text_before_cursor(ctx):lower()
  return before:match("%f[%w_]from%f[^%w_]%s+[%w_%.%\"`%[]*$") ~= nil
    or before:match("%f[%w_]join%f[^%w_]%s+[%w_%.%\"`%[]*$") ~= nil
end

local function referenced_tables(sql, schema)
  local seen = {}
  local tables = {}

  for table_name in sql:gmatch("%f[%w_][Ff][Rr][Oo][Mm]%f[^%w_]%s+[%\"`%[]?([%w_%.]+)") do
    table_name = table_name:gsub('^.*%.', '')
    table_name = table_name:gsub('[%\"`%]]', '')
    if schema.columns_by_table[table_name] and not seen[table_name] then
      seen[table_name] = true
      table.insert(tables, table_name)
    end
  end

  for table_name in sql:gmatch("%f[%w_][Jj][Oo][Ii][Nn]%f[^%w_]%s+[%\"`%[]?([%w_%.]+)") do
    table_name = table_name:gsub('^.*%.', '')
    table_name = table_name:gsub('[%\"`%]]', '')
    if schema.columns_by_table[table_name] and not seen[table_name] then
      seen[table_name] = true
      table.insert(tables, table_name)
    end
  end

  return tables
end

function M.new()
  return setmetatable({}, { __index = M })
end

function M:enabled()
  return vim.tbl_contains({ "sql", "mysql", "plsql" }, vim.bo.filetype) and get_db_path() ~= nil
end

function M:get_trigger_characters()
  return { ".", '"', "`" }
end

function M:get_completions(ctx, callback)
  local schema = load_schema()
  if not schema then
    callback({ context = ctx, is_incomplete_forward = true, items = {} })
    return function() end
  end

  local prefix = current_word(ctx):lower()
  local sql = buffer_sql_text()
  local tables_in_query = referenced_tables(sql, schema)
  local items = {}
  local seen = {}

  local function add(label, kind, detail)
    if label == "" or seen[label .. kind] then
      return
    end
    if prefix ~= "" and not label:lower():find(prefix, 1, true) then
      return
    end
    seen[label .. kind] = true
    table.insert(items, {
      label = label,
      insertText = label,
      kind = kind,
      labelDetails = { description = detail },
    })
  end

  if is_table_context(ctx) then
    for _, table_name in ipairs(schema.tables) do
      add(table_name, CompletionItemKind.Class, "DuckDB table")
    end
  elseif #tables_in_query > 0 then
    for _, table_name in ipairs(tables_in_query) do
      for _, column_name in ipairs(schema.columns_by_table[table_name] or {}) do
        add(column_name, CompletionItemKind.Field, table_name)
      end
    end
  else
    for column_name in pairs(schema.columns) do
      add(column_name, CompletionItemKind.Field, "DuckDB column")
    end
  end

  callback({
    context = ctx,
    is_incomplete_forward = true,
    is_incomplete_backward = true,
    items = items,
  })

  return function() end
end

function M.clear_cache()
  cache = {}
end

return M
