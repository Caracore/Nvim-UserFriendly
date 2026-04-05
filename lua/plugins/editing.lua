return {

  -- ── Marqueurs visuels dans la gouttière (m{a-z}, '{a-z}) ──────────────
  {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    opts  = {
      default_mappings     = true,  -- mx, dmx, m/, etc.
      builtin_marks        = { ".", "<", ">", "^" },
      cyclic               = true,
      force_write_shada    = true,
      refresh_interval     = 250,
      sign_priority        = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      bookmark_0 = { sign = "⚑", virt_text = "Bookmark", annotate = false },
      mappings             = {},
    },
  },

  -- ── Entourer du texte (ys, cs, ds) ────────────────────────────────────
  -- ys{motion}{char}  → ajouter    ex: ysiw"  ysa(}
  -- cs{old}{new}      → changer    ex: cs"'   cs({
  -- ds{char}          → supprimer  ex: ds"    ds(
  {
    "kylechui/nvim-surround",
    event   = "VeryLazy",
    version = "*",
    opts    = {},
  },

  -- ── Fermeture automatique des brackets / quotes ─────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts  = {
      check_ts              = true,   -- intégration Treesitter
      ts_config             = {
        lua  = { "string" },
        javascript = { "template_string" },
      },
      disable_filetype      = { "TelescopePrompt", "vim" },
      fast_wrap             = {
        map      = "<M-e>",   -- Alt+e pour fast-wrap
        chars    = { "{", "[", "(", '"', "'" },
        pattern  = [=[[%'%"%>%]%)%}%,]]=],
        end_key  = "$",
        keys     = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight   = "PmenuSel",
      },
    },
  },

  -- ── Commentaires (gcc = ligne, gc{motion} = bloc) ────────────────────
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts  = {
      padding   = true,
      sticky    = true,
      toggler   = { line = "gcc", block = "gbc" },
      opleader  = { line = "gc",  block = "gb" },
      extra     = {
        above = "gcO",  -- commentaire au-dessus
        below = "gco",  -- commentaire en-dessous
        eol   = "gcA",  -- commentaire en fin de ligne
      },
    },
  },

  -- ── Navigation rapide (s + 2 lettres = saut direct) ──────────────────
  -- s{aa}     → saute vers "aa" visible à l'écran
  -- S{aa}     → saute en arrière
  -- f/t/F/T   → améliorés avec labels
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts  = {
      modes = {
        search = { enabled = true },  -- intégration / et ?
        char   = {
          enabled    = true,
          jump_labels = true,
        },
      },
    },
    keys = {
      { "s",     function() require("flash").jump()              end, desc = "Flash jump",          mode = { "n", "x", "o" } },
      { "S",     function() require("flash").treesitter()        end, desc = "Flash Treesitter",    mode = { "n", "x", "o" } },
      { "r",     function() require("flash").remote()            end, desc = "Flash Remote",        mode = "o" },
      { "<C-s>", function() require("flash").toggle()            end, desc = "Toggle Flash Search", mode = "c" },
    },
  },

  -- ── Search & Replace global dans le projet ────────────────────────────
  -- <leader>sr → ouvre le panneau de remplacement
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd  = "GrugFar",
    keys = {
      { "<leader>sr", "<cmd>GrugFar<cr>",                                          desc = "Search & Replace projet" },
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Remplacer mot sous curseur", mode = { "n" } },
    },
  },

}
