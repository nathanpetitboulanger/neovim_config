return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"

    -- On définit le moteur ici, proprement
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = "-lualatex",
    }

    -- On ne définit QUE les options supplémentaires.
    -- Ne rajoute PAS "-pdflua" ici, car l'engine au dessus s'en occupe déjà.
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end,
}
