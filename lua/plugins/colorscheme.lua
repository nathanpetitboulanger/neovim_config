-- Keep selector-managed colorschemes installed and eager so an existing
-- Neovim instance can switch themes without changing lazy.nvim's spec graph.
return {
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  { "Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
  { "bjarneo/ethereal.nvim", lazy = false, priority = 1000 },
  { "neanias/everforest-nvim", lazy = false, priority = 1000 },
  { "kepano/flexoki-neovim", lazy = false, priority = 1000 },
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
  {
    "bjarneo/hackerman.nvim",
    dependencies = { "bjarneo/aether.nvim" },
    lazy = false,
    priority = 1000,
  },
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
  { "omacom-io/lumon.nvim", lazy = false, priority = 1000 },
  { "bjarneo/lupine.nvim", lazy = false, priority = 1000 },
  { "tahayvr/matteblack.nvim", lazy = false, priority = 1000 },
  { "xero/miasma.nvim", lazy = false, priority = 1000 },
  { "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
  { "ribru17/bamboo.nvim", lazy = false, priority = 1000 },
  { "OldJobobo/retro-82.nvim", lazy = false, priority = 1000 },
  { "loctvl842/monokai-pro.nvim", lazy = false, priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 },
  { "ficcdaf/ashen.nvim", lazy = false, priority = 1000 },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "bjarneo/vantablack.nvim", lazy = false, priority = 1000 },
  { "datsfilipe/vesper.nvim", lazy = false, priority = 1000 },
  { "bjarneo/white.nvim", lazy = false, priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = function()
        require("config.theme").apply()
      end
    end,
  },
}
