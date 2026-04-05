return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      -- Extension file browser avec preview
      {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
      -- Tri natif plus rapide (optionnel mais recommandé)
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Chercher fichiers" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",                 desc = "Chercher dans fichiers" },
      { "<leader>fb", "<cmd>Telescope file_browser<cr>",              desc = "Explorateur fichiers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                  desc = "Fichiers récents" },
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.55,   -- 55% de l'écran pour la preview
              width = 0.90,
              height = 0.85,
            },
          },
          preview = {
            -- Active la preview par défaut
            hide_on_startup = false,
            -- Limite la taille des fichiers prévisualisés (en KB)
            filesize_limit = 1,
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        extensions = {
          file_browser = {
            -- Démarre dans le dossier du fichier courant
            path = "%:p:h",
            cwd_to_path = true,
            -- Affiche les dossiers en premier
            grouped = true,
            hidden = true,      -- Montre les fichiers cachés
            hijack_netrw = true, -- Remplace netrw (nvim .) par file_browser
            previewer = true,    -- Preview activée
            layout_config = {
              horizontal = {
                preview_width = 0.55,
                width = 0.90,
                height = 0.85,
              },
            },
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      })

      telescope.load_extension("file_browser")
      telescope.load_extension("fzf")
    end,
    init = function()
      -- Ouvre automatiquement file_browser quand on fait `nvim .` ou `nvim <dossier>`
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local arg = vim.fn.argv(0)
          if type(arg) == "string" and vim.fn.isdirectory(arg) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(arg))
            -- Petit délai pour laisser Neovim s'initialiser
            vim.schedule(function()
              require("telescope").extensions.file_browser.file_browser({ path = arg })
            end)
          end
        end,
      })
    end,
  },
}
