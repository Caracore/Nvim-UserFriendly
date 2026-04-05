return {

  -- Gestionnaire d'installation des serveurs LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts  = { ui = { border = "rounded" } },
  },

  -- Pont Mason ↔ lspconfig (installe les binaires des serveurs)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local U = require("config.user")
      return {
        ensure_installed    = U.lsp.servers,
        automatic_enable    = false,  -- on gère nous-mêmes via vim.lsp.enable
      }
    end,
  },

  -- Définitions des serveurs LSP (cmd, filetypes, root_dir…)
  {
    "neovim/nvim-lspconfig",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ── Keymaps LSP via autocmd LspAttach (API 0.11) ────────────────
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("NvimLspKeymaps", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local map   = function(key, cmd, desc)
            vim.keymap.set("n", key, cmd, { buffer = bufnr, silent = true, desc = desc })
          end
          -- Navigation
          map("gd",         vim.lsp.buf.definition,                    "Aller à la définition")
          map("gD",         vim.lsp.buf.declaration,                   "Aller à la déclaration")
          map("gr",         vim.lsp.buf.references,                    "Références")
          map("gi",         vim.lsp.buf.implementation,                "Implémentation")
          map("K",          vim.lsp.buf.hover,                         "Documentation")
          map("<C-k>",      vim.lsp.buf.signature_help,                "Signature")
          -- Actions
          map("<leader>cr", vim.lsp.buf.rename,                        "Renommer")
          map("<leader>ca", vim.lsp.buf.code_action,                   "Actions code")
          map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Formater")
          -- Diagnostics
          map("<leader>xd", vim.diagnostic.open_float,                 "Diagnostic détail")
          map("[d",         function() vim.diagnostic.jump({ count = -1 }) end, "Diagnostic précédent")
          map("]d",         function() vim.diagnostic.jump({ count =  1 }) end, "Diagnostic suivant")
          map("<leader>xl", "<cmd>Telescope diagnostics<cr>",          "Liste diagnostics")
        end,
      })

      -- ── Icônes dans la gouttière ─────────────────────────────────────
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰌶 ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
        virtual_text     = { prefix = "●" },
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
      })

      -- ── Capabilities globales (toutes langues) ───────────────────────
      vim.lsp.config("*", { capabilities = capabilities })

      -- ── Config spécifique par serveur ────────────────────────────────
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime     = { version = "LuaJIT" },
            workspace   = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
            telemetry   = { enable = false },
          },
        },
      })

      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = { typeCheckingMode = "basic" },
          },
        },
      })

      -- ── Activation de tous les serveurs listés dans user.lua ─────────
      local U = require("config.user")
      vim.lsp.enable(U.lsp.servers)
    end,
  },
}
