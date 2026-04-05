local U = require("config.user")

return {
  { "folke/tokyonight.nvim",    lazy = true },
  { "catppuccin/nvim",          name = "catppuccin", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rose-pine/neovim",         name = "rose-pine",  lazy = true },
  { "rebelot/kanagawa.nvim",    lazy = true },
  { "EdenEast/nightfox.nvim",   lazy = true },

  -- Chargeur universel — s'adapte au thème choisi dans user.lua
  {
    "rose-pine/neovim",        -- plugin de base pour priority=1000
    name     = "rose-pine-loader",
    lazy     = false,
    priority = 1000,
    config   = function()
      -- Configure chaque thème selon la transparence
      pcall(function() require("tokyonight").setup({ transparent = U.transparent }) end)
      pcall(function() require("catppuccin").setup({ transparent_background = U.transparent }) end)
      pcall(function() require("rose-pine").setup({ disable_background = U.transparent }) end)
      pcall(function() require("kanagawa").setup({ transparent = U.transparent }) end)

      local ok = pcall(vim.cmd.colorscheme, U.colorscheme)
      if not ok then
        vim.notify("Thème '" .. U.colorscheme .. "' introuvable → habamax", vim.log.levels.WARN)
        vim.cmd.colorscheme("habamax")
      end
    end,
  },
}
