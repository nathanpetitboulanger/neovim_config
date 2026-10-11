local M = {}

local state_file = vim.fn.stdpath("config") .. "/lua/config/desktop-theme.lua"
local themes_dir = vim.fn.expand("~/.config/themes")

local function setup(module_name, opts)
  local module = require(module_name)
  if type(module.setup) == "function" then
    module.setup(opts or {})
  end
end

-- Selector pack names are the stable interface. Colorscheme names and setup
-- details stay here because several packs use a differently named plugin.
local themes = {
  ["catppuccin"] = {
    colorscheme = "catppuccin-nvim",
    background = "dark",
    setup = function()
      setup("catppuccin", { flavour = "mocha" })
    end,
  },
  ["catppuccin-latte"] = {
    colorscheme = "catppuccin-latte",
    background = "light",
    setup = function()
      setup("catppuccin", { flavour = "latte" })
    end,
  },
  dracula = { colorscheme = "dracula", background = "dark" },
  ethereal = { colorscheme = "ethereal", background = "dark" },
  everforest = {
    colorscheme = "everforest",
    background = "dark",
    setup = function()
      setup("everforest", { background = "soft" })
    end,
  },
  ["flexoki-light"] = { colorscheme = "flexoki-light", background = "light" },
  gruvbox = { colorscheme = "gruvbox", background = "dark" },
  hacker = { colorscheme = "hacker", background = "dark" },
  hackerman = { colorscheme = "hackerman", background = "dark" },
  hud = { colorscheme = "hud", background = "dark" },
  kanagawa = { colorscheme = "kanagawa", background = "dark" },
  ["last-horizon"] = { colorscheme = "desktop", background = "dark" },
  latte = {
    colorscheme = "catppuccin-latte",
    background = "light",
    setup = function()
      setup("catppuccin", { flavour = "latte" })
    end,
  },
  lumon = { colorscheme = "lumon", background = "dark" },
  lupine = { colorscheme = "lupine", background = "light" },
  ["matte-black"] = { colorscheme = "matteblack", background = "dark" },
  miasma = { colorscheme = "miasma", background = "dark" },
  mocha = {
    colorscheme = "catppuccin-mocha",
    background = "dark",
    setup = function()
      setup("catppuccin", { flavour = "mocha" })
    end,
  },
  nord = { colorscheme = "nordfox", background = "dark" },
  original = {
    colorscheme = "tokyonight",
    background = "dark",
    setup = function()
      setup("tokyonight", { style = "moon" })
    end,
  },
  ["osaka-jade"] = { colorscheme = "bamboo", background = "dark" },
  ["retro-82"] = { colorscheme = "retro-82", background = "dark" },
  ristretto = {
    colorscheme = "monokai-pro",
    background = "dark",
    after = function()
      require("monokai-pro").set_filter("ristretto")
    end,
  },
  ["rose-pine"] = { colorscheme = "rose-pine-dawn", background = "light" },
  solitude = { colorscheme = "ashen", background = "dark" },
  ["tokyo-night"] = {
    colorscheme = "tokyonight-night",
    background = "dark",
    setup = function()
      setup("tokyonight", { style = "night" })
    end,
  },
  vantablack = { colorscheme = "vantablack", background = "dark" },
  vesper = { colorscheme = "vesper", background = "dark" },
  white = { colorscheme = "white", background = "light" },
}

local function active_pack_from_kitty()
  local theme_file = vim.fn.resolve(vim.fn.expand("~/.config/kitty/current-theme.conf"))
  local pack = theme_file:match("/themes/([^/]+)/kitty%.conf$")
  if pack and themes[pack] then
    return pack
  end
end

function M.selected()
  if vim.uv.fs_stat(state_file) then
    local ok, value = pcall(dofile, state_file)
    if ok and type(value) == "string" and themes[value] then
      return value
    end
    if ok and type(value) == "table" and type(value.pack) == "string" and themes[value.pack] then
      return value.pack
    end
  end

  return active_pack_from_kitty() or "original"
end

local function generated_fallback_exists(pack)
  return vim.uv.fs_stat(themes_dir .. "/" .. pack .. "/nvim.lua") ~= nil
end

local function notify_failure(pack, colorscheme, error_message, fallback)
  vim.schedule(function()
    vim.notify(
      ("Could not load %s for %s: %s\nUsing %s instead."):format(colorscheme, pack, error_message, fallback),
      vim.log.levels.WARN,
      { title = "Desktop theme" }
    )
  end)
end

function M.apply(pack)
  pack = pack or M.selected()
  local theme = themes[pack]
  if not theme then
    notify_failure(pack, "unknown colorscheme", "unknown selector pack", "habamax")
    vim.cmd.colorscheme("habamax")
    return false
  end

  vim.o.background = theme.background

  local errors = {}
  if theme.setup then
    local ok, err = pcall(theme.setup)
    if not ok then
      table.insert(errors, "setup failed: " .. tostring(err))
    end
  end

  local colorscheme_ok, colorscheme_error = pcall(vim.cmd.colorscheme, theme.colorscheme)
  if not colorscheme_ok then
    table.insert(errors, tostring(colorscheme_error))
  elseif theme.after then
    local ok, err = pcall(theme.after)
    if not ok then
      table.insert(errors, "post-load setup failed: " .. tostring(err))
    end
  end

  if #errors == 0 then
    M.current = pack
    return true
  end

  local fallback = generated_fallback_exists(pack) and "desktop" or "habamax"
  local fallback_ok, fallback_err = pcall(vim.cmd.colorscheme, fallback)
  local message = table.concat(errors, "; ")
  if not fallback_ok then
    message = message .. "; fallback failed: " .. tostring(fallback_err)
  end
  notify_failure(pack, theme.colorscheme, message, fallback)
  M.current = pack
  return false
end

function M.list()
  return vim.deepcopy(themes)
end

return M
