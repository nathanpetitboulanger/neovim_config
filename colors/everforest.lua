vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "everforest"

local c = {
  bg = "#2d353b",
  bg2 = "#343f44",
  bg3 = "#3d484d",
  bg4 = "#475258",
  fg = "#d3c6aa",
  red = "#e67e80",
  orange = "#e69875",
  yellow = "#dbbc7f",
  green = "#a7c080",
  aqua = "#83c092",
  blue = "#7fbbb3",
  purple = "#d699b6",
  grey = "#7a8478",
  grey1 = "#859289",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg2 })
hl("FloatBorder", { fg = c.green, bg = c.bg2 })
hl("Comment", { fg = c.grey1, italic = true })
hl("Constant", { fg = c.purple })
hl("String", { fg = c.green })
hl("Character", { fg = c.green })
hl("Number", { fg = c.purple })
hl("Boolean", { fg = c.purple })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.green })
hl("Statement", { fg = c.red })
hl("Keyword", { fg = c.red })
hl("PreProc", { fg = c.purple })
hl("Type", { fg = c.yellow })
hl("Special", { fg = c.orange })
hl("Operator", { fg = c.orange })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.yellow, bold = true })
hl("LineNr", { fg = c.grey })
hl("CursorLine", { bg = c.bg2 })
hl("CursorLineNr", { fg = c.green, bold = true })
hl("Visual", { bg = "#543a48" })
hl("Search", { fg = c.bg, bg = c.green })
hl("IncSearch", { fg = c.bg, bg = c.orange })
hl("StatusLine", { fg = c.fg, bg = c.bg2 })
hl("StatusLineNC", { fg = c.grey1, bg = c.bg2 })
hl("VertSplit", { fg = c.bg4 })
hl("WinSeparator", { fg = c.bg4 })
hl("Pmenu", { fg = c.fg, bg = c.bg3 })
hl("PmenuSel", { fg = c.bg, bg = c.green })
hl("PmenuSbar", { bg = c.bg2 })
hl("PmenuThumb", { bg = c.bg4 })
hl("DiffAdd", { fg = c.green })
hl("DiffChange", { fg = c.blue })
hl("DiffDelete", { fg = c.red })
hl("DiffText", { fg = c.yellow })
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.green })
hl("Title", { fg = c.orange, bold = true })
hl("Directory", { fg = c.green })
hl("MatchParen", { fg = c.orange, bold = true })
hl("Underlined", { fg = c.blue, underline = true })

hl("@comment", { link = "Comment" })
hl("@keyword", { link = "Keyword" })
hl("@function", { link = "Function" })
hl("@string", { link = "String" })
hl("@variable", { link = "Identifier" })
hl("@type", { link = "Type" })
hl("@constant", { link = "Constant" })
hl("@number", { link = "Number" })
hl("@operator", { link = "Operator" })
