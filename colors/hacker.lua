vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "hacker"

local c = {
  bg = "#050805",
  bg2 = "#0d1a0d",
  bg3 = "#1a3d1a",
  fg = "#33ff66",
  bright = "#b4ffc8",
  green = "#00ff41",
  dim = "#00aa44",
  yellow = "#ccff00",
  red = "#ff3333",
  cyan = "#66ffcc",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg2 })
hl("FloatBorder", { fg = c.green, bg = c.bg2 })
hl("Comment", { fg = c.bg3, italic = true })
hl("Constant", { fg = c.yellow })
hl("String", { fg = c.dim })
hl("Character", { fg = c.dim })
hl("Number", { fg = c.yellow })
hl("Boolean", { fg = c.green })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.green })
hl("Statement", { fg = c.green })
hl("Keyword", { fg = c.green, bold = true })
hl("PreProc", { fg = c.cyan })
hl("Type", { fg = c.cyan })
hl("Special", { fg = c.yellow })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.yellow, bold = true })
hl("LineNr", { fg = c.bg3 })
hl("CursorLine", { bg = c.bg2 })
hl("CursorLineNr", { fg = c.green, bold = true })
hl("Visual", { bg = c.bg3 })
hl("Search", { fg = c.bg, bg = c.green })
hl("IncSearch", { fg = c.bg, bg = c.yellow })
hl("StatusLine", { fg = c.fg, bg = c.bg2 })
hl("StatusLineNC", { fg = c.bg3, bg = c.bg2 })
hl("VertSplit", { fg = c.bg3 })
hl("WinSeparator", { fg = c.bg3 })
hl("Pmenu", { fg = c.fg, bg = c.bg2 })
hl("PmenuSel", { fg = c.bg, bg = c.green })
hl("PmenuSbar", { bg = c.bg2 })
hl("PmenuThumb", { bg = c.bg3 })
hl("DiffAdd", { fg = c.green })
hl("DiffChange", { fg = c.yellow })
hl("DiffDelete", { fg = c.red })
hl("DiffText", { fg = c.cyan })
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.cyan })
hl("DiagnosticHint", { fg = c.dim })
hl("Title", { fg = c.green, bold = true })
hl("Directory", { fg = c.green })
hl("MatchParen", { fg = c.yellow, bold = true })
hl("Underlined", { fg = c.cyan, underline = true })

hl("@comment", { link = "Comment" })
hl("@keyword", { link = "Keyword" })
hl("@function", { link = "Function" })
hl("@string", { link = "String" })
hl("@variable", { link = "Identifier" })
hl("@type", { link = "Type" })
hl("@constant", { link = "Constant" })
hl("@number", { link = "Number" })
