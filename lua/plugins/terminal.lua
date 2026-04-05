return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>ft", "<cmd>ToggleTerm direction=float<cr>",      desc = "Terminal flottant" },
      { "<leader>fT", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal horizontal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then return 15
        elseif term.direction == "vertical" then return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping    = nil,    -- on utilise nos propres keymaps
      direction       = "float",
      float_opts      = { border = "curved" },
      shade_terminals = true,
      shading_factor  = 2,
      close_on_exit   = true,
      shell           = vim.o.shell,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Esc pour quitter le mode terminal et fermer
      vim.keymap.set("t", "<Esc>", "<cmd>ToggleTerm<cr>", { desc = "Fermer terminal", silent = true })
      -- Ctrl+w pour naviguer vers une autre fenêtre depuis le terminal
      vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Fenêtre depuis terminal", silent = true })
    end,
  },
}
