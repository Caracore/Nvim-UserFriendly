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
        { "<leader>f", group = "  Fichiers" },
        { "<leader>g", group = "  Git" },
        { "<leader>b", group = "  Buffers" },
        { "<leader>s", group = "  Recherche" },
        { "<leader>u", group = "  UI / Toggle" },
        { "<leader>w", group = "  Fenêtres" },
        { "<leader>c", group = "  Code / LSP" },
        { "<leader>x", group = "  Diagnostics" },
      },
    },
  },
}
