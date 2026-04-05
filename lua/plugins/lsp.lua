return {

  -- Gestionnaire d'installation des serveurs LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts  = { ui = { border = "rounded" } },
  },

  -- Pont Mason ↔ lspconfig (installe + configure automatiquement)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local U = require("config.user")
      return {
        ensure_installed = U.lsp.servers,
        automatic_installation = true,
      }
    end,
  },

  -- Configuration LSP
  {
    "neovim/nvim-lspconfig",
    event        = { "BufReadPre", "BufNewFile" },  -- charge seulement à l'ouverture d'un fichier
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",   -- capabilities LSP pour cmp
    },
    config = function()
      local lspconfig  = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps LSP actifs uniquement quand un serveur est attaché
      local on_attach = function(_, bufnr)
        local map = function(key, cmd, desc)
          vim.keymap.set("n", key, cmd, { buffer = bufnr, silent = true, desc = desc })
        end

        -- Navigation
        map("gd",         vim.lsp.buf.definition,       "Aller à la définition")
        map("gD",         vim.lsp.buf.declaration,      "Aller à la déclaration")
        map("gr",         vim.lsp.buf.references,       "Références")
        map("gi",         vim.lsp.buf.implementation,   "Implémentation")
        map("K",          vim.lsp.buf.hover,            "Documentation")
        map("<C-k>",      vim.lsp.buf.signature_help,   "Signature")
        -- Actions
        map("<leader>cr", vim.lsp.buf.rename,           "Renommer")
        map("<leader>ca", vim.lsp.buf.code_action,      "Actions code")
        map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Formater")
        -- Diagnostics
        map("<leader>xd", vim.diagnostic.open_float,    "Diagnostic détail")
        map("[d",         vim.diagnostic.goto_prev,     "Diagnostic précédent")
        map("]d",         vim.diagnostic.goto_next,     "Diagnostic suivant")
        map("<leader>xl", "<cmd>Telescope diagnostics<cr>", "Liste diagnostics")
      end

      -- Icônes de diagnostic dans la gouttière
      local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text   = { prefix = "●" },
        signs          = true,
        underline      = true,
        update_in_insert = false,   -- pas de diagnostics en mode insertion (perf)
        severity_sort  = true,
      })

      -- Config spéciale pour lua_ls (reconnaît l'API Neovim)
      local server_settings = {
        lua_ls = {
          settings = {
            Lua = {
              runtime     = { version = "LuaJIT" },
              workspace   = { checkThirdParty = false },
              diagnostics = { globals = { "vim" } },
              telemetry   = { enable = false },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = { typeCheckingMode = "basic" },  -- "off" | "basic" | "strict"
            },
          },
        },
      }

      -- Active chaque serveur listé dans user.lua
      local U = require("config.user")
      for _, server in ipairs(U.lsp.servers) do
        local config = server_settings[server] or {}
        config.capabilities = capabilities
        config.on_attach    = on_attach
        lspconfig[server].setup(config)
      end
    end,
  },
}
