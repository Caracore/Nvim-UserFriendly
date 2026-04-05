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
  colorscheme = "rose-pine",

  -- ---------------------------------------------------------------
  --  TRANSPARENCE
  --  true  → fond transparent (dépend du terminal)
  --  false → fond opaque
  -- ---------------------------------------------------------------
  transparent = false,

  -- ---------------------------------------------------------------
  --  CURSEUR
  --  Style  : "block" | "line" | "underline"
  --  Smear  : animation de déplacement du curseur
  -- ---------------------------------------------------------------
  cursor = {
    style = "block",   -- "block" | "line" | "underline"

    smear = {
      enabled  = true,

      -- Vitesse de l'animation (0.0 → 1.0)
      --   0.1 = très lent/fluide   0.6 = rapide/nerveux
      stiffness          = 0.3,
      trailing_stiffness = 0.15,

      -- Distance minimale (en colonnes) pour déclencher l'animation
      distance_stop_animating = 0.5,

      -- Couleur du smear : "auto" = suit le curseur, ou code hex ex: "#ff79c6"
      color = "auto",

      -- true  = cache le vrai curseur pendant l'animation (plus propre)
      -- false = les deux sont visibles
      hide_target = true,

      -- Active le support des symboles legacy (terminaux anciens)
      legacy_computing = false,
    },
  },

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
  --  DASHBOARD — ASCII art affiché au démarrage
  --  Chaque ligne est une entrée du tableau.
  -- ---------------------------------------------------------------
  dashboard_header = {
    "                                                ",
    "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗ ██╗",
    "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ██║",
    "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔██╗ ██║",
    "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╗██║",
    "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚████║",
    "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝  ╚═══╝",
    "                                                ",
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
