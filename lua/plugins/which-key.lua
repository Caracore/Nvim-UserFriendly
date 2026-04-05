return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300  -- délai avant affichage de la popup (ms)
    end,
    opts = {
      preset = "modern",  -- style moderne comme LazyVim
      icons = {
        mappings = true,
        keys = {
          Space = "󱁐 ",
          CR    = "↵ ",
          Esc   = "⎋ ",
          BS    = "⌫ ",
        },
      },
      -- Groupes de touches avec labels (apparaissent en couleur dans la popup)
      spec = {
        { "<leader>f",  group = "  Fichiers" },
        { "<leader>g",  group = "  Git" },
        { "<leader>b",  group = "  Buffers" },
        { "<leader>s",  group = "  Recherche" },
        { "<leader>u",  group = "  UI / Toggle" },
        { "<leader>c",  group = "  Code / LSP",
          { "<leader>cr", desc = "Renommer" },
          { "<leader>ca", desc = "Actions code" },
          { "<leader>cf", desc = "Formater" },
        },
        { "<leader>x",  group = "  Diagnostics",
          { "<leader>xd", desc = "Détail diagnostic" },
          { "<leader>xl", desc = "Liste diagnostics" },
        },
        { "<leader>w",  group = "  Fenêtres",
          { "<leader>ww", desc = "Cycle fenêtres" },
          { "<leader>wh", desc = "← Gauche" },
          { "<leader>wl", desc = "→ Droite" },
          { "<leader>wj", desc = "↓ Bas" },
          { "<leader>wk", desc = "↑ Haut" },
          { "<leader>wv", desc = "Split vertical" },
          { "<leader>ws", desc = "Split horizontal" },
          { "<leader>wq", desc = "Fermer" },
        },
        { "<leader>o",  desc = "  Focus tree" },
        { "<leader>e",  desc = "  Toggle tree" },
      },
    },
  },
}
