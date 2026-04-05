-- ============================================================
--  NVIM+ Extra : Prettier + Conform
--  Formatters automatiques multi-langages.
--  Conform utilise les formatters installés sur le système.
--  Installez prettier : npm install -g prettier
-- ============================================================
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo", "Format" },
    keys  = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Formater (Prettier)",
      },
    },
    opts = {
      -- Format automatique à la sauvegarde
      format_on_save = {
        timeout_ms   = 1000,
        lsp_fallback = true,  -- utilise le LSP si le formatter est absent
      },

      -- Formatters par type de fichier
      formatters_by_ft = {
        -- Web
        javascript       = { "prettier" },
        javascriptreact  = { "prettier" },
        typescript       = { "prettier" },
        typescriptreact  = { "prettier" },
        html             = { "prettier" },
        css              = { "prettier" },
        scss             = { "prettier" },
        json             = { "prettier" },
        jsonc            = { "prettier" },
        yaml             = { "prettier" },
        markdown         = { "prettier" },
        -- Python
        python           = { "black", "isort" },
        -- Lua
        lua              = { "stylua" },
        -- Go
        go               = { "gofmt" },
        -- Rust
        rust             = { "rustfmt" },
        -- Shell
        sh               = { "shfmt" },
        bash             = { "shfmt" },
        -- C / C++
        c                = { "clang_format" },
        cpp              = { "clang_format" },
      },

      -- Config personnalisée de prettier (évite d'avoir un .prettierrc)
      formatters = {
        prettier = {
          prepend_args = {
            "--tab-width",     "2",
            "--single-quote",  "true",
            "--trailing-comma", "es5",
            "--print-width",   "100",
          },
        },
      },
    },
  },
}
