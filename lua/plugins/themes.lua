local U = require("config.user")

-- Groupes à rendre transparents (bg = NONE)
local transparent_groups = {
  "Normal", "NormalNC", "NormalFloat",
  "SignColumn", "FoldColumn", "LineNr", "CursorLineNr",
  "EndOfBuffer", "FloatBorder", "FloatTitle",
  "StatusLine", "StatusLineNC",
  "TabLine", "TabLineFill",
  "Pmenu", "PmenuSbar",
  -- Neo-tree
  "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer",
  -- Noice
  "NoiceCmdlinePopup", "NoiceCmdlinePopupBorder",
  -- Telescope
  "TelescopeNormal", "TelescopeBorder",
  "TelescopePromptNormal", "TelescopePromptBorder",
}

local function apply_transparency()
  if not U.transparent then return end
  for _, group in ipairs(transparent_groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok then
      hl.bg  = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end

return {
  { "folke/tokyonight.nvim",    lazy = true },
  { "catppuccin/nvim",          name = "catppuccin", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rose-pine/neovim",         name = "rose-pine",  lazy = true },
  { "rebelot/kanagawa.nvim",    lazy = true },
  { "EdenEast/nightfox.nvim",   lazy = true },

  {
    "rose-pine/neovim",
    name     = "rose-pine-loader",
    lazy     = false,
    priority = 1000,
    config   = function()
      pcall(function() require("tokyonight").setup({ transparent = U.transparent }) end)
      pcall(function() require("catppuccin").setup({ transparent_background = U.transparent }) end)
      pcall(function() require("rose-pine").setup({ disable_background = U.transparent }) end)
      pcall(function() require("kanagawa").setup({ transparent = U.transparent }) end)

      local ok = pcall(vim.cmd.colorscheme, U.colorscheme)
      if not ok then
        vim.notify("Thème '" .. U.colorscheme .. "' introuvable → habamax", vim.log.levels.WARN)
        vim.cmd.colorscheme("habamax")
      end

      -- Force la transparence après chargement du colorscheme
      apply_transparency()

      -- Ré-applique après chaque changement de colorscheme
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = apply_transparency,
      })
    end,
  },
}
