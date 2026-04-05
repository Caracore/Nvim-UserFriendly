-- ============================================================
--  NVIM+ Extra : Supermaven
--  IA d'autocomplétion ultra-rapide, gratuit sans compte.
--  Commandes : :SupermavenStatus  :SupermavenToggle
-- ============================================================
return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    cond  = function() return require("config.user").extras.supermaven end,
    opts  = {
      keymaps = {
        accept_suggestion = "<M-CR>",   -- Alt+Entrée pour accepter
        clear_suggestion  = "<C-]>",    -- Ctrl+] pour ignorer
        accept_word       = "<M-w>",    -- Alt+W pour accepter un mot
      },
      ignore_filetypes = {
        "TelescopePrompt",
        "neo-tree",
        "alpha",
      },
      color = {
        suggestion_color = "#6e6a86",  -- couleur grisée de la suggestion
        cterm            = 244,
      },
      log_level     = "off",
      disable_inline_completion = false,
      disable_keymaps           = false,
    },
  },
}
