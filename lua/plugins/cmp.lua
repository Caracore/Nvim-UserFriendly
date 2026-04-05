return {

  -- Moteur d'autocomplétion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",   -- ne charge qu'en mode insertion
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",    -- source LSP
      "hrsh7th/cmp-buffer",      -- source mots du buffer
      "hrsh7th/cmp-path",        -- source chemins fichiers
      "saadparwaiz1/cmp_luasnip", -- source snippets
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")
      local U       = require("config.user").lsp.completion

      cmp.setup({
        preselect = U.preselect and cmp.PreselectMode.Item or cmp.PreselectMode.None,

        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },

        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-j>"]   = cmp.mapping.select_next_item(),
          ["<C-k>"]   = cmp.mapping.select_prev_item(),
          ["<C-d>"]   = cmp.mapping.scroll_docs(4),
          ["<C-u>"]   = cmp.mapping.scroll_docs(-4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]   = cmp.mapping.abort(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
          -- Tab : confirme ou passe au prochain placeholder du snippet
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = U.max_items },
          { name = "luasnip",  max_item_count = 5 },
        }, {
          { name = "buffer",   max_item_count = 5, keyword_length = 3 },
          { name = "path" },
        }),

        -- Mise en forme des suggestions (type + icône)
        formatting = {
          format = function(entry, item)
            local icons = {
              Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
              Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
              Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎠",
              Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
              File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
              Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
              TypeParameter = "",
            }
            item.kind = (icons[item.kind] or "") .. " " .. item.kind
            item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip  = "[Snip]",
              buffer   = "[Buf]",
              path     = "[Path]",
            })[entry.source.name]
            return item
          end,
        },
      })
    end,
  },
}
