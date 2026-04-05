return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha   = require("alpha")
      local theme   = require("alpha.themes.dashboard")
      local U       = require("config.user")

      -- ASCII art depuis user.lua
      theme.section.header.val = U.dashboard_header
      theme.section.header.opts = {
        hl        = "AlphaHeader",
        position  = "center",
      }

      -- Boutons raccourcis
      theme.section.buttons.val = {
        theme.button("e",  "  Nouveau fichier",        "<cmd>ene <BAR> startinsert<cr>"),
        theme.button("f",  "  Chercher fichier",       "<cmd>Telescope find_files<cr>"),
        theme.button("r",  "  Fichiers récents",       "<cmd>Telescope oldfiles<cr>"),
        theme.button("g",  "  Chercher texte",         "<cmd>Telescope live_grep<cr>"),
        theme.button("c",  "  Configuration",          "<cmd>e ~/.config/nvim/lua/config/user.lua<cr>"),
        theme.button("l",  "󰒲  Lazy (plugins)",         "<cmd>Lazy<cr>"),
        theme.button("q",  "  Quitter",                "<cmd>qa<cr>"),
      }

      -- Pied de page avec version de neovim
      theme.section.footer.val = function()
        local v = vim.version()
        return "  Neovim v" .. v.major .. "." .. v.minor .. "." .. v.patch
      end
      theme.section.footer.opts = { hl = "AlphaFooter", position = "center" }

      -- Espacement
      theme.config.layout = {
        { type = "padding", val = 4 },
        theme.section.header,
        { type = "padding", val = 2 },
        theme.section.buttons,
        { type = "padding", val = 1 },
        theme.section.footer,
      }

      alpha.setup(theme.config)

      -- Ferme le dashboard quand on ouvre un fichier
      vim.api.nvim_create_autocmd("User", {
        pattern  = "AlphaReady",
        callback = function()
          vim.opt_local.showtabline = 0
          vim.opt_local.laststatus  = 0
        end,
      })
      vim.api.nvim_create_autocmd("BufUnload", {
        buffer   = 0,
        callback = function()
          vim.opt.showtabline = 2
          vim.opt.laststatus  = 3
        end,
      })
    end,
  },
}
