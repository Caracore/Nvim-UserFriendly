-- ============================================================
--  NVIM+ Extra : GitHub Copilot
--  Requires: abonnement GitHub Copilot
--  Commandes : :Copilot setup  (première utilisation)
-- ============================================================
return {
  -- Moteur Copilot (Lua pur, remplace le plugin officiel vim)
  {
    "zbirenbaum/copilot.lua",
    cmd   = "Copilot",
    event = "InsertEnter",
    opts  = {
      suggestion = {
        enabled      = true,
        auto_trigger = true,
        keymap = {
          accept      = "<M-CR>",   -- Alt+Entrée pour accepter
          accept_word = "<M-w>",    -- Alt+W pour accepter un mot
          next        = "<M-]>",
          prev        = "<M-[>",
          dismiss     = "<C-]>",
        },
      },
      panel = { enabled = false },  -- on utilise cmp à la place
    },
  },

  -- Source Copilot pour nvim-cmp (suggestions dans la liste de complétion)
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
      -- Injecte la source copilot dans cmp si déjà chargé
      local ok, cmp = pcall(require, "cmp")
      if ok then
        cmp.setup({ sources = cmp.config.sources(
          vim.list_extend(
            cmp.get_config().sources,
            { { name = "copilot", group_index = 1 } }
          )
        )})
      end
    end,
  },
}
