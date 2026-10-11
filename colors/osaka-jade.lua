vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "osaka-jade"

local c = {
  bg = "#111c18",
  bg2 = "#23372b",
  bg3 = "#53685b",
  fg = "#c1c497",
  cream = "#f6f5dd",
  cursor = "#d7c995",
  red = "#ff5345",
  green = "#549e6a",
  yellow = "#e5c736",
  blue = "#509475",
  magenta = "#d2689c",
  cyan = "#2dd5b7",
  jade = "#71cead",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg2 })
hl("FloatBorder", { fg = c.jade, bg = c.bg2 })
hl("Comment", { fg = c.bg3, italic = true })
hl("Constant", { fg = c.yellow })
hl("String", { fg = c.green })
hl("Character", { fg = c.green })
hl("Number", { fg = c.yellow })
hl("Boolean", { fg = c.magenta })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.cyan })
hl("Statement", { fg = c.jade })
hl("Keyword", { fg = c.cyan })
hl("PreProc", { fg = c.blue })
hl("Type", { fg = c.jade })
hl("Special", { fg = c.cursor })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.yellow, bold = true })
hl("LineNr", { fg = c.bg3 })
hl("CursorLine", { bg = c.bg2 })
hl("CursorLineNr", { fg = c.jade, bold = true })
hl("Visual", { bg = c.bg2 })
hl("Search", { fg = c.bg, bg = c.jade })
hl("IncSearch", { fg = c.bg, bg = c.cursor })
hl("StatusLine", { fg = c.fg, bg = c.bg2 })
hl("StatusLineNC", { fg = c.bg3, bg = c.bg2 })
hl("VertSplit", { fg = c.bg3 })
hl("WinSeparator", { fg = c.bg3 })
hl("Pmenu", { fg = c.fg, bg = c.bg2 })
hl("PmenuSel", { fg = c.bg, bg = c.jade })
hl("PmenuSbar", { bg = c.bg2 })
hl("PmenuThumb", { bg = c.bg3 })
hl("DiffAdd", { fg = c.green })
hl("DiffChange", { fg = c.yellow })
hl("DiffDelete", { fg = c.red })
hl("DiffText", { fg = c.cyan })
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.cyan })
hl("DiagnosticHint", { fg = c.jade })
hl("Title", { fg = c.jade, bold = true })
hl("Directory", { fg = c.cyan })
hl("MatchParen", { fg = c.cursor, bold = true })
hl("Underlined", { fg = c.cyan, underline = true })

hl("@comment", { link = "Comment" })
hl("@keyword", { link = "Keyword" })
hl("@function", { link = "Function" })
hl("@string", { link = "String" })
hl("@variable", { link = "Identifier" })
hl("@type", { link = "Type" })
hl("@constant", { link = "Constant" })
hl("@number", { link = "Number" })
