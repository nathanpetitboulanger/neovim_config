-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Term for gemini
--
local Terminal = require("toggleterm.terminal").Terminal

-- On définit une "recette" pour notre terminal Gemini
local gemini_terminal = Terminal:new({
  cmd = "gemini", -- La commande exacte qui se lance
  direction = "float", -- On veut qu'il flotte par-dessus le code
  hidden = true, -- Ne se lance pas tout seul au démarrage
  close_on_exit = true, -- Ferme la fenêtre si tu quittes Gemini
  float_opts = {
    border = "curved", -- Pour le style
  },
  -- Important pour toi :
  on_open = function(term)
    -- On force le mode insertion dès qu'on l'ouvre
    vim.cmd("startinsert!")
  end,
})

function _G.toggle_gemini()
  gemini_terminal:toggle()
end

vim.keymap.set("n", "<leader>a", "<cmd>lua toggle_gemini()<CR>", { noremap = true, silent = true })
