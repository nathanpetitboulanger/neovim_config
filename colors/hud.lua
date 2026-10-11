vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "hud"

local c = {
  bg = "#061618",
  bg2 = "#0c2226",
  bg3 = "#1a3d40",
  fg = "#c8f5ed",
  cyan = "#5eead4",
  sky = "#67e8f9",
  teal = "#2dd4bf",
  yellow = "#fde68a",
  red = "#f87171",
  muted = "#3d6b68",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg2 })
hl("FloatBorder", { fg = c.cyan, bg = c.bg2 })
hl("Comment", { fg = c.muted, italic = true })
hl("Constant", { fg = c.yellow })
hl("String", { fg = c.teal })
hl("Character", { fg = c.teal })
hl("Number", { fg = c.yellow })
hl("Boolean", { fg = c.cyan })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.sky })
hl("Statement", { fg = c.cyan })
hl("Keyword", { fg = c.cyan, bold = true })
hl("PreProc", { fg = c.sky })
hl("Type", { fg = c.teal })
hl("Special", { fg = c.yellow })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.yellow, bold = true })
hl("LineNr", { fg = c.bg3 })
hl("CursorLine", { bg = c.bg2 })
hl("CursorLineNr", { fg = c.cyan, bold = true })
hl("Visual", { bg = c.bg3 })
hl("Search", { fg = c.bg, bg = c.cyan })
hl("IncSearch", { fg = c.bg, bg = c.yellow })
hl("StatusLine", { fg = c.fg, bg = c.bg2 })
hl("StatusLineNC", { fg = c.muted, bg = c.bg2 })
hl("VertSplit", { fg = c.bg3 })
hl("WinSeparator", { fg = c.bg3 })
hl("Pmenu", { fg = c.fg, bg = c.bg2 })
hl("PmenuSel", { fg = c.bg, bg = c.cyan })
hl("PmenuSbar", { bg = c.bg2 })
hl("PmenuThumb", { bg = c.bg3 })
hl("DiffAdd", { fg = c.teal })
hl("DiffChange", { fg = c.yellow })
hl("DiffDelete", { fg = c.red })
hl("DiffText", { fg = c.sky })
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.sky })
hl("DiagnosticHint", { fg = c.cyan })
hl("Title", { fg = c.cyan, bold = true })
hl("Directory", { fg = c.sky })
hl("MatchParen", { fg = c.yellow, bold = true })
hl("Underlined", { fg = c.sky, underline = true })

hl("@comment", { link = "Comment" })
hl("@keyword", { link = "Keyword" })
hl("@function", { link = "Function" })
hl("@string", { link = "String" })
hl("@variable", { link = "Identifier" })
hl("@type", { link = "Type" })
hl("@constant", { link = "Constant" })
hl("@number", { link = "Number" })
