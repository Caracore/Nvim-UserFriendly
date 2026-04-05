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
  -- transparent = false,
  transparent = true,

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
  --  SAUVEGARDE
  -- ---------------------------------------------------------------
  save = {
    -- Notification visuelle après sauvegarde (style LazyVim, en bas)
    notify = true,

    -- Son à la sauvegarde
    --   false      → silence
    --   "bell"     → bip terminal (universel)
    --   "system"   → son système via paplay (Linux)
    sound = "system",

    -- Fichier son utilisé quand sound = "system"
    -- Autres options :
    --   /usr/share/sounds/freedesktop/stereo/bell.oga
    --   /usr/share/sounds/freedesktop/stereo/message.oga
    --   /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
    --   /usr/share/sounds/sound-icons/piano-3.wav
    sound_file = "/usr/share/sounds/freedesktop/stereo/complete.oga",
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
    { "<leader>q",  "<cmd>qa<cr>", "Quitter" },

    -- ── Édition ───────────────────────────────────────────────────────
    -- Déplacer une ligne vers le haut / bas (Alt+j / Alt+k)
    { "<A-j>", "<cmd>m .+1<cr>==",  "Déplacer ligne bas" },
    { "<A-k>", "<cmd>m .-2<cr>==",  "Déplacer ligne haut" },
    -- Dupliquer la ligne sous le curseur
    { "<leader>d", "<cmd>t.<cr>",   "Dupliquer ligne" },
    -- Supprimer sans polluer le registre (vers le registre noir _)
    { "<leader>D", '"_dd',          "Supprimer (sans registre)" },
    -- Coller sans écraser le registre en mode visuel
    -- (défini dans init.lua car il faut mode "x")
    -- Meilleure indentation en mode visuel (reste en sélection)
    -- (défini dans init.lua)

    -- ── Marks ─────────────────────────────────────────────────────────
    -- (marks.nvim ajoute les keymaps natifs m{x}, '{x}, dm{x} etc.)
    -- Liste tous les marks du buffer
    { "<leader>mm", "<cmd>MarksListBuf<cr>",  "Liste marks buffer" },
    { "<leader>mg", "<cmd>MarksListGlobal<cr>", "Liste marks globaux" },

    -- ── Search & Replace ──────────────────────────────────────────────
    { "<leader>sr", "<cmd>GrugFar<cr>", "Search & Replace projet" },
    -- Vider le surlignage de recherche
    { "<Esc>",      "<cmd>nohlsearch<cr>", "Effacer surbrillance" },

    -- ── Navigation ────────────────────────────────────────────────────
    -- Centrer l'écran après saut (n/N/Ctrl+d/Ctrl+u)
    { "n",     "nzzzv",   "Suivant (centré)" },
    { "N",     "Nzzzv",   "Précédent (centré)" },
    { "<C-d>", "<C-d>zz", "Demi-page bas (centré)" },
    { "<C-u>", "<C-u>zz", "Demi-page haut (centré)" },
    -- Jump list
    { "<C-o>", "<C-o>",   "Retour dans jump list" },
    { "<C-i>", "<C-i>",   "Avant dans jump list" },

    -- ── Buffers ───────────────────────────────────────────────────────
    { "<leader>ba", "<cmd>bufdo bdelete<cr>",  "Fermer tous les buffers" },
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
