-- ================================================================
--  user.lua — Configuration personnelle
--  C'est LE seul fichier à modifier pour personnaliser le setup.
-- ================================================================

return {

  -- ---------------------------------------------------------------
  --  THÈME
  --  Choix disponibles :
  --   ── Thèmes custom (conçus pour ce setup) ──────────────────
  --    "cyber"    → Cyberpunk neon  (bleu/rose/cyan électrique)
  --    "forest"   → Nature sombre   (verts profonds + or ambré)
  --    "ember"    → Feu & braises   (orange/rouge — idéal avec cursor fire)
  --    "void"     → Ultra minimal   (quasi noir, distraction zéro)
  --   ── Thèmes externes (installés via lazy) ──────────────────
  --    "tokyonight-night"   "tokyonight-storm"   "tokyonight-day"
  --    "catppuccin-mocha"   "catppuccin-macchiato" "catppuccin-latte"
  --    "gruvbox"            "rose-pine"           "rose-pine-moon"
  --    "kanagawa"           "nightfox"            "nordfox"
  -- ---------------------------------------------------------------
  colorscheme = "ember",

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
    style = "line",   -- "block" | "line" | "underline"

    smear = {
      enabled  = true,

      -- Preset visuel :
      --   "default"  → smear standard
      --   "fire"     → curseur en feu 🔥 (particules + couleur orange)
      --   "fast"     → smear rapide et nerveux
      --   "smooth"   → curseur lisse sans traîne
      preset = "fire",

      -- Couleur du smear (ignorée si preset = "fire")
      --   "auto"       → suit le colorscheme
      --   "#rrggbb"    → couleur fixe
      color = "auto",

      -- true  = cache le vrai curseur pendant l'animation
      hide_target = true,

      -- Active le support des symboles legacy (terminaux anciens / Cascadia Code)
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
    -- Fenêtres — splits
    { "<leader>wv", "<cmd>vsplit<cr>",   "Split vertical" },
    { "<leader>ws", "<cmd>split<cr>",    "Split horizontal" },
    { "<leader>wq", "<cmd>close<cr>",    "Fermer fenêtre" },
    -- Fenêtres — navigation avec <leader>w + direction
    { "<leader>ww", "<C-w>w",            "Cycle fenêtres" },
    { "<leader>wh", "<C-w>h",            "Fenêtre gauche" },
    { "<leader>wl", "<C-w>l",            "Fenêtre droite" },
    { "<leader>wj", "<C-w>j",            "Fenêtre bas" },
    { "<leader>wk", "<C-w>k",            "Fenêtre haut" },
    -- Fenêtres — navigation rapide Ctrl+direction (sans C-h = backspace)
    { "<C-l>",      "<C-w>l",            "Fenêtre droite" },
    { "<C-j>",      "<C-w>j",            "Fenêtre bas" },
    { "<C-k>",      "<C-w>k",            "Fenêtre haut" },
    -- Focus neo-tree
    { "<leader>o",  "<cmd>Neotree focus<cr>", "Focus tree" },
    -- Sauvegarder (normal + insertion + visuel)
    { "<C-s>", "<cmd>write<cr>", "Sauvegarder" },
    -- Quitter
    { "<leader>q",  "<cmd>qa<cr>",                      "Quitter" },
  },

  -- ---------------------------------------------------------------
  --  NVIM+ — Modules optionnels
  --  Tout est FALSE par défaut — activez uniquement ce dont vous avez besoin.
  --
  --  ⚠ Copilot et Supermaven font la même chose (IA inline).
  --    Activez-en UN seul à la fois maximum.
  --
  --  Copilot    : nécessite un abonnement GitHub + :Copilot setup
  --  Supermaven : gratuit mais demande une activation au 1er lancement
  --  Prettier   : nécessite  npm install -g prettier
  -- ---------------------------------------------------------------
  extras = {
    copilot    = false,  -- GitHub Copilot    → activer : true
    supermaven = false,  -- Supermaven AI     → activer : true
    prettier   = false,  -- Prettier/conform  → activer : true
  },

  -- ---------------------------------------------------------------
  --  LSP — Serveurs à installer et activer
  --  Ajoutez / commentez selon vos besoins.
  --  Mason les installe automatiquement au démarrage.
  --  Chaque serveur ne démarre QUE si le bon type de fichier est ouvert.
  -- ---------------------------------------------------------------
  lsp = {
    servers = {
      -- Web
      "html",           -- HTML
      "cssls",          -- CSS / SCSS
      "ts_ls",          -- JavaScript / TypeScript
      "jsonls",         -- JSON
      -- Backend
      "pyright",        -- Python
      "gopls",          -- Go
      "rust_analyzer",  -- Rust
      "clangd",         -- C / C++
      "bashls",         -- Bash / Shell
      -- Config & DevOps
      "yamlls",         -- YAML
      "taplo",          -- TOML
      "dockerls",       -- Dockerfile
      -- Markup
      "marksman",       -- Markdown
      -- Lua (Neovim)
      "lua_ls",         -- Lua
    },

    -- Comportement de l'autocomplétion
    completion = {
      -- Nombre max de suggestions affichées
      max_items = 10,
      -- Sélectionner automatiquement le premier item
      preselect = true,
    },
  },
}
