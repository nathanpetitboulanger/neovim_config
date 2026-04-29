-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Initialiser Molten avec ton kernel "myproject"
--
-- -- Raccourcis pour la Data Science (Molten)
local map = vim.keymap.set

-- Faire monter/descendre la vue sans déplacer le curseur
map("n", "<A-j>", "1<C-e>", { desc = "Descendre la vue" })
map("n", "<A-k>", "1<C-y>", { desc = "Monter la vue" })

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
  -- Dossier du fichier actuel, avec fallback sur la racine du projet
  local dir = vim.fn.expand("%:p:h")
  if dir == "" or dir == "." then
    dir = LazyVim.root()
  end

  -- On utilise une commande unique qui :
  -- 1. split verticalement (vsplit)
  -- 2. change le dossier de travail (lcd) pour cette fenêtre uniquement
  -- 3. lance le terminal
  vim.cmd("vsplit | lcd " .. dir .. " | terminal uv run ipython --no-autoindent")
  -- On passe en mode insertion
end

-- On associe cette fonction à un raccourci clavier (ex: <leader>zi pour "Z-IPython")
vim.keymap.set("n", "<leader>zi", open_ipython_project, { desc = "Ouvrir IPython avec uv (Projet)" })

local function open_node_project()
  local root = LazyVim.root()
  vim.cmd("vsplit | lcd " .. root .. " | terminal node " .. vim.fn.stdpath("config") .. "/scripts/node-repl.js")
end

vim.keymap.set("n", "<leader>zj", open_node_project, { desc = "Ouvrir Node REPL (Projet)" })

-- Permet de sortir du mode terminal avec la touche Escape
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- -- GEMINI --
-- vim.keymap.set("n", "<leader>af", function()
--   local input = vim.fn.input("Instruction Gemini : ")
--   if input ~= "" then
--     vim.cmd("vsplit | term gemini '" .. input .. " dans %'")
--   end
-- end, { desc = "Gemini Interactive" })
--
-- vim.keymap.set("n", "<leader>as", ":vsplit | term gemini<CR>", { desc = "Open gemini on vsplit" })
-- vim.keymap.set("t", "<A-q>", [[<C-\><C-n>]], { desc = "Sortir du mode terminal" })
-- vim.keymap.set("n", "<leader>j", "<cmd>lua toggle_gemini()<CR>", { noremap = true, silent = true })

-- CLAUDE --
vim.keymap.set("n", "<leader>af", function()
  local input = vim.fn.input("Instruction Claude : ")
  if input ~= "" then
    vim.cmd("vsplit | term claude --dangerously-skip-permissions'" .. input .. " dans %'")
  end
end, { desc = "Claude Interactive" })

vim.keymap.set("n", "<leader>as", ":vsplit | term claude<CR>", { desc = "Open claude on vsplit" })
vim.keymap.set("t", "<A-q>", [[<C-\><C-n>]], { desc = "Sortir du mode terminal" })
vim.keymap.set("n", "<leader>j", "<cmd>lua toggle_claude()<CR>", { noremap = true, silent = true })

-- Diff entre maintenant et le dernier commit
vim.keymap.set("n", "<leader>ghh", function()
  require("gitsigns").diffthis("HEAD")
end, { desc = "Diff This HEAD" })

vim.keymap.set("n", "<leader>gH", "<cmd>terminal git diff HEAD<CR>", { desc = "Git Diff HEAD (repo)" })

