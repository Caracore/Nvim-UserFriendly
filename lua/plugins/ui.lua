return {

  -- Cmdline flottante au centre + notifications (style LazyVim)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",  -- fenêtre flottante au centre
        format = {
          cmdline   = { icon = ">" },
          search_down = { icon = "🔍⌄" },
          search_up   = { icon = "🔍⌃" },
        },
      },
      messages = { enabled = true },
      popupmenu = { enabled = true, backend = "nui" },
      notify = { enabled = true },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,   -- positionne la cmdline comme une palette
        long_message_to_split = true,
      },
    },
  },

  -- Arborescence (position et largeur depuis user.lua)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = function()
      local U = require("config.user")
      return {
        window = {
          position = U.tree.position,
          width    = U.tree.width,
        },
        filesystem = {
          follow_current_file    = { enabled = true },
          hijack_netrw_behavior  = "open_current",
        },
      }
    end,
  },
}
