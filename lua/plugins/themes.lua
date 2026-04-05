-- Tous les thèmes disponibles dans user.lua sont listés ici.
-- Seul celui choisi dans user.lua sera chargé au démarrage.
local U = require("config.user")

return {
  { "folke/tokyonight.nvim",    lazy = true },
  { "catppuccin/nvim",          name = "catppuccin", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rose-pine/neovim",         name = "rose-pine",  lazy = true },
  { "rebelot/kanagawa.nvim",    lazy = true },
  { "EdenEast/nightfox.nvim",   lazy = true },

  -- Chargement du thème choisi
  {
    "folke/tokyonight.nvim",
    lazy     = false,
    priority = 1000,
    config = function()
      -- Transparence pour les thèmes qui le supportent
      require("tokyonight").setup({ transparent = U.transparent })
      require("catppuccin").setup({ transparent_background = U.transparent })

      local ok = pcall(vim.cmd.colorscheme, U.colorscheme)
      if not ok then
        vim.notify(
          "Thème '" .. U.colorscheme .. "' introuvable, utilisation de la valeur par défaut.",
          vim.log.levels.WARN
        )
        vim.cmd.colorscheme("habamax")
      end
    end,
  },
}
