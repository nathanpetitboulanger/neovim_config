-- Seamless Ctrl+h/j/k/l navigation across Neovim splits and Herdr panes.
-- Based on paulbkim-dev/vim-herdr-navigation/editor/nvim.lua.
-- This local integration also supports Neovim terminal mode.

local function focus_outer_multiplexer(direction)
  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
    local herdr = vim.env.HERDR_BIN_PATH
    if herdr == nil or herdr == "" then
      herdr = "herdr"
    end
    -- Target Neovim's containing pane explicitly. `--current` can resolve to
    -- another client-focused pane when this tab is not the active Herdr tab.
    vim.fn.system({ herdr, "pane", "focus", "--direction", direction, "--pane", vim.env.HERDR_PANE_ID })
  elseif vim.env.TMUX and vim.env.TMUX ~= "" then
    local tmux_direction = { left = "Left", down = "Down", up = "Up", right = "Right" }
    pcall(vim.cmd, "TmuxNavigate" .. tmux_direction[direction])
  end
end

local function navigate(wincmd, direction)
  local previous_window = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)

  if vim.api.nvim_get_current_win() == previous_window then
    focus_outer_multiplexer(direction)
  end
end

local function map(lhs, wincmd, direction, description)
  vim.keymap.set({ "n", "t" }, lhs, function()
    navigate(wincmd, direction)
  end, { silent = true, noremap = true, desc = description })
end

map("<C-h>", "h", "left", "Navigate left (Vim/Herdr)")
map("<C-j>", "j", "down", "Navigate down (Vim/Herdr)")
map("<C-k>", "k", "up", "Navigate up (Vim/Herdr)")
map("<C-l>", "l", "right", "Navigate right (Vim/Herdr)")
