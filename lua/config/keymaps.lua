-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Defined elsewhere:
--   vim-slime (<leader>ps/pa/pw)          lua/plugins/data-science.lua

local map = vim.keymap.set

-- Ctrl+h/j/k/l across Neovim splits and Herdr panes (normal + terminal).
-- Loaded from here so it overrides LazyVim's default window keymaps.
require("config.herdr_nav")

-- ── Vue ───────────────────────────────────────────────────────────────
-- Faire monter/descendre la vue sans déplacer le curseur
map("n", "<A-j>", "1<C-e>", { desc = "Descendre la vue" })
map("n", "<A-k>", "1<C-y>", { desc = "Monter la vue" })

-- ── Terminal ──────────────────────────────────────────────────────────
-- Sortir du mode terminal avec Escape (ou Alt+q)
map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("t", "<A-q>", [[<C-\><C-n>]], { desc = "Sortir du mode terminal" })

-- ── Data science : Molten (Jupyter) & Quarto ──────────────────────────
-- Initialiser le kernel Jupyter (à faire une fois par fichier)
map("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten (Jupyter)" })
-- Exécuter le code couvert par un mouvement (ex: Espace + m + o puis ip pour un paragraphe)
map("n", "<leader>mo", ":MoltenEvaluateOperator<CR>", { desc = "Molten: evaluate operator" })
-- Exécuter une sélection visuelle (surligne ton code puis fait Espace + m + v)
map("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Execute visual selection" })
-- Afficher le résultat Molten
map("n", "<leader>ms", ":MoltenShowOutput<CR>", { desc = "Molten: Show Output" })
-- Entrer dans la fenêtre de résultat / d'erreur
map("n", "<leader>me", ":MoltenEnterOutput<CR>", { desc = "Entrer dans l'erreur" })
-- Supprimer le résultat affiché
map("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Delete Molten output" })
-- Prévisualisation Quarto (affiche le HTML/PDF dans le navigateur)
map("n", "<leader>qp", ":QuartoPreview<CR>", { desc = "Quarto Preview" })

-- ── REPLs (à utiliser avec vim-slime) ─────────────────────────────────
-- Ouvre `cmd` dans un terminal en split vertical, avec `dir` comme dossier
-- de travail pour cette fenêtre uniquement (lcd)
local function open_repl(dir, cmd)
  vim.cmd("vsplit | lcd " .. vim.fn.fnameescape(dir) .. " | terminal " .. cmd)
end

map("n", "<leader>zi", function()
  -- Dossier du fichier actuel, avec fallback sur la racine du projet
  local dir = vim.fn.expand("%:p:h")
  if dir == "" or dir == "." then
    dir = LazyVim.root()
  end
  open_repl(dir, "uv run ipython --no-autoindent")
end, { desc = "Ouvrir IPython avec uv (Projet)" })

map("n", "<leader>zj", function()
  open_repl(LazyVim.root(), "node " .. vim.fn.stdpath("config") .. "/scripts/node-repl.js")
end, { desc = "Ouvrir Node REPL (Projet)" })

-- ── Git ───────────────────────────────────────────────────────────────
-- Diff entre maintenant et le dernier commit
map("n", "<leader>ghh", function()
  require("gitsigns").diffthis("HEAD")
end, { desc = "Diff This HEAD" })
map("n", "<leader>gH", "<cmd>terminal git diff HEAD<CR>", { desc = "Git Diff HEAD (repo)" })
