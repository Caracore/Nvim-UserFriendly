return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = function()
      local U = require("config.user")

      -- Icônes de mode comme LazyVim
      local mode_map = {
        NORMAL   = "NORMAL",  INSERT  = "INSERT",
        VISUAL   = "VISUAL",  ["V-LINE"] = "V-LINE",
        ["V-BLOCK"] = "V-BLOCK", COMMAND = "COMMAND",
        REPLACE  = "REPLACE", SELECT  = "SELECT",
      }

      -- Composant : nom du fichier + état modifié/readonly
      local filename = {
        "filename",
        path      = 1,         -- 0=nom seul, 1=relatif, 2=absolu
        symbols   = { modified = "●", readonly = "", unnamed = "[No Name]" },
      }

      -- Composant : diagnostics LSP
      local diagnostics = {
        "diagnostics",
        sources  = { "nvim_lsp", "nvim_diagnostic" },
        symbols  = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
      }

      -- Composant : diff git
      local diff = {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
      }

      return {
        options = {
          theme                = "auto",    -- suit le colorscheme de user.lua
          globalstatus         = true,      -- une seule statusline en bas
          disabled_filetypes   = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, padding = { left = 1, right = 1 } } },
          lualine_b = { { "branch", icon = "" }, diff },
          lualine_c = { filename, diagnostics },
          lualine_x = {
            -- Affiche la macro enregistrée (comme LazyVim)
            {
              function()
                local reg = vim.fn.reg_recording()
                return reg ~= "" and "  @" .. reg or ""
              end,
              color = { fg = "#ff9e64" },
            },
            -- Affiche la musique Spotify en cours (si extra activé)
            {
              function() return _G.SpotifyStatus and _G.SpotifyStatus() or "" end,
              cond = function()
                local ok, U = pcall(require, "config.user")
                return ok and (U.extras or {}).spotify == true
              end,
              color = { fg = "#1db954" },  -- vert Spotify
            },
            { "filetype", icon_only = false },
          },
          lualine_y = {
            { "encoding" },
            { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
          },
          lualine_z = {
            { "progress", separator = { right = "" }, padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
        },
        -- Statusline des buffers inactifs
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { filename },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
