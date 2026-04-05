-- ================================================================
--  user.lua — Configuration personnelle
--  C'est LE seul fichier à modifier pour personnaliser le setup.
-- ================================================================

return {

  -- ---------------------------------------------------------------
  --  THÈME
  --  Choix disponibles :
  --    "tokyonight-night"   "tokyonight-storm"   "tokyonight-day"
  --    "catppuccin-mocha"   "catppuccin-macchiato" "catppuccin-latte"
  --    "gruvbox"            "rose-pine"           "rose-pine-moon"
  --    "kanagawa"           "nightfox"            "nordfox"
  -- ---------------------------------------------------------------
  colorscheme = "tokyonight-night",

  -- ---------------------------------------------------------------
  --  TRANSPARENCE
  --  true  → fond transparent (dépend du terminal)
  --  false → fond opaque
  -- ---------------------------------------------------------------
  transparent = false,

  -- ---------------------------------------------------------------
  --  CURSEUR
  --  Styles : "block" | "line" | "underline"
  -- ---------------------------------------------------------------
  cursor = "block",

  -- ---------------------------------------------------------------
  --  EXPLORATEUR DE FICHIERS (neo-tree)
  -- ---------------------------------------------------------------
  tree = {
    position = "right",   -- "right" | "left"
    width    = 35,
  },

  -- ---------------------------------------------------------------
  --  ÉDITEUR
  -- ---------------------------------------------------------------
  editor = {
    tab_size       = 4,
    line_numbers   = true,
    relative_nums  = true,
    wrap           = false,
    scroll_off     = 8,
  },

  -- ---------------------------------------------------------------
  --  KEYMAPS  (leader = Espace)
  --  Format : { clé, commande, description }
  -- ---------------------------------------------------------------
  keymaps = {
    -- Explorateur
    { "<leader>e",  "<cmd>Neotree toggle<cr>",          "Toggle tree" },
    -- Telescope
    { "<leader>ff", "<cmd>Telescope find_files<cr>",    "Chercher fichiers" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",     "Chercher texte" },
    { "<leader>fb", "<cmd>Telescope file_browser<cr>",  "Explorateur" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",      "Fichiers récents" },
    -- Buffers
    { "<leader>bd", "<cmd>bdelete<cr>",                 "Fermer buffer" },
    { "<Tab>",      "<cmd>bnext<cr>",                   "Buffer suivant" },
    { "<S-Tab>",    "<cmd>bprevious<cr>",               "Buffer précédent" },
    -- Fenêtres
    { "<leader>wv", "<cmd>vsplit<cr>",                  "Split vertical" },
    { "<leader>wh", "<cmd>split<cr>",                   "Split horizontal" },
    { "<leader>wq", "<cmd>close<cr>",                   "Fermer fenêtre" },
    -- Navigation entre fenêtres (sans C-h, conflit avec Backspace terminal)
    { "<C-l>",      "<C-w>l",                           "Fenêtre droite" },
    { "<C-j>",      "<C-w>j",                           "Fenêtre bas" },
    { "<C-k>",      "<C-w>k",                           "Fenêtre haut" },
    -- Sauvegarder
    { "<C-s>",      "<cmd>w<cr>",                       "Sauvegarder" },
    -- Quitter
    { "<leader>q",  "<cmd>qa<cr>",                      "Quitter" },
  },
}
