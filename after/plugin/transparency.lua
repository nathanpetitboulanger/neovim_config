local transparent_groups = {
  "Normal",
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "Terminal",
  "EndOfBuffer",
  "FoldColumn",
  "Folded",
  "SignColumn",
  "NormalNC",
  "WhichKeyFloat",
  "TelescopeBorder",
  "TelescopeNormal",
  "TelescopePromptBorder",
  "TelescopePromptTitle",
  "NeoTreeNormal",
  "NeoTreeNormalNC",
  "NeoTreeVertSplit",
  "NeoTreeWinSeparator",
  "NeoTreeEndOfBuffer",
  "NvimTreeNormal",
  "NvimTreeVertSplit",
  "NvimTreeEndOfBuffer",
  "NotifyINFOBody",
  "NotifyERRORBody",
  "NotifyWARNBody",
  "NotifyTRACEBody",
  "NotifyDEBUGBody",
  "NotifyINFOTitle",
  "NotifyERRORTitle",
  "NotifyWARNTitle",
  "NotifyTRACETitle",
  "NotifyDEBUGTitle",
  "NotifyINFOBorder",
  "NotifyERRORBorder",
  "NotifyWARNBorder",
  "NotifyTRACEBorder",
  "NotifyDEBUGBorder",
}

local function apply_transparency()
  for _, group in ipairs(transparent_groups) do
    local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
    if next(highlight) ~= nil then
      highlight.bg = nil
      highlight.ctermbg = nil
      vim.api.nvim_set_hl(0, group, highlight)
    end
  end
end

local group = vim.api.nvim_create_augroup("desktop_theme_transparency", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = apply_transparency,
})

apply_transparency()
