-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Initialiser Molten avec ton kernel "myproject"
--
-- -- Raccourcis pour la Data Science (Molten)
local map = vim.keymap.set

-- Initialiser le kernel Jupyter (à faire une fois par fichier)
map("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten (Jupyter)" })

-- Exécuter la cellule (bloc de code) sous le curseur
map("n", "<leader>me", ":MoltenEvaluateOperator<CR>", { desc = "Execute code cell" })

-- Exécuter une sélection visuelle (surligne ton code puis fait Espace + m + v)
map("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Execute visual selection" })

-- Supprimer le résultat affiché
map("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Delete Molten output" })

-- Prévisualisation Quarto (affiche le HTML/PDF dans le navigateur)
map("n", "<leader>qp", ":QuartoPreview<CR>", { desc = "Quarto Preview" })

-- Associer Space + m + s à l'affichage du résultat Molten
map("n", "<leader>ms", ":MoltenShowOutput<CR>", { desc = "Molten: Show Output" })

-- On se contente d'entrer dans la fenêtre d'erreur
map("n", "<leader>me", ":MoltenEnterOutput<CR>", { desc = "Entrer dans l'erreur" })

-- Permet de changer de fenêtre depuis le terminal avec Ctrl + h/j/k/l
-- 't' signifie Terminal Mode
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Fenêtre gauche" })
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Fenêtre bas" })
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Fenêtre haut" })
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Fenêtre droite" })

local function open_ipython_project()
  local root = LazyVim.root()

  -- On utilise une commande unique qui :
  -- 1. split verticalement (vsplit)
  -- 2. change le dossier de travail (lcd) pour cette fenêtre uniquement
  -- 3. lance le terminal
  vim.cmd("vsplit | lcd " .. root .. " | terminal uv run ipython --no-autoindent")
  -- On passe en mode insertion
end

-- On associe cette fonction à un raccourci clavier (ex: <leader>zi pour "Z-IPython")
vim.keymap.set("n", "<leader>zi", open_ipython_project, { desc = "Ouvrir IPython avec uv (Projet)" })

-- Permet de sortir du mode terminal avec la touche Escape
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- AI --
vim.keymap.set("n", "<leader>af", function()
  local input = vim.fn.input("Instruction Gemini : ")
  if input ~= "" then
    vim.cmd("vsplit | term gemini '" .. input .. " dans %'")
  end
end, { desc = "Gemini Interactive" })

vim.keymap.set("n", "<leader>as", ":vsplit | term gemini<CR>", { desc = "Open gemini on vsplit" })
vim.keymap.set("t", "<A-q>", [[<C-\><C-n>]], { desc = "Sortir du mode terminal" })
vim.keymap.set("n", "<leader>j", "<cmd>lua toggle_gemini()<CR>", { noremap = true, silent = true })
