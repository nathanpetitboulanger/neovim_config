function! db#adapter#duckdb#canonicalize(url) abort
  return db#url#canonicalize_file(a:url)
endfunction

function! db#adapter#duckdb#test_file(file) abort
  if getfsize(a:file) < 100
    return
  endif
  let firstline = readfile(a:file, '', 1)[0]
  " DuckDB can also open SQLite databases
  if firstline[8:11] ==# 'DUCK' || firstline =~# '^SQLite format 3\n'
    return 1
  endif
endfunction

function! s:path(url) abort
  let path = db#url#file_path(a:url)
  if path =~# '^[\/]\=$'
    if !exists('s:session')
      let s:session = tempname() . '.duckdb'
    endif
    let path = s:session
  endif
  return path
endfunction

function! db#adapter#duckdb#dbext(url) abort
  return {'dbname': s:path(a:url)}
endfunction

function! db#adapter#duckdb#command(url) abort
  return ['duckdb', s:path(a:url)]
endfunction

function! db#adapter#duckdb#interactive(url) abort
  return db#adapter#duckdb#command(a:url) + ['-box', '-header']
endfunction

function! db#adapter#duckdb#auth_input() abort
  " DuckDB file databases do not need an authentication probe. Skipping it also
  " avoids opening a write connection just to initialise completion.
  return v:false
endfunction

function! db#adapter#duckdb#tables(url) abort
  " DuckDB 1.5 changed `.tables` to a rich, colored schema summary. That breaks
  " vim-dadbod-completion because vim-dadbod's upstream adapter splits `.tables`
  " output into words. Query information_schema instead for one table per line.
  let query = "select table_name from information_schema.tables where table_schema not in ('information_schema','pg_catalog') order by table_name"
  return filter(db#systemlist(['duckdb', '-readonly', s:path(a:url), '-noheader', '-csv', '-c', query]), 'v:val !=# ""')
endfunction

function! db#adapter#duckdb#massage(input) abort
  return a:input . "\n;"
endfunction
