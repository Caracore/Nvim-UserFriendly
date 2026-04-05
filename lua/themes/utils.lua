-- lua/themes/utils.lua
-- Fonctions utilitaires partagées par tous les thèmes custom

local M = {}

-- Applique une table de highlight groups
-- hl = { GroupName = { fg="#hex", bg="#hex", bold=true, ... } }
function M.apply(hl)
  for group, opts in pairs(hl) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

-- Initialise un nouveau thème (efface tout, positionne le nom)
function M.init(name)
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
  vim.o.termguicolors = true
  vim.g.colors_name   = name
end

-- Construit les highlights Treesitter depuis les groupes de base
function M.treesitter(c)
  return {
    ["@comment"]              = { link = "Comment" },
    ["@keyword"]              = { link = "Keyword" },
    ["@keyword.function"]     = { link = "Keyword" },
    ["@keyword.return"]       = { fg = c.keyword, italic = true },
    ["@function"]             = { link = "Function" },
    ["@function.call"]        = { fg = c.func, italic = true },
    ["@function.builtin"]     = { fg = c.builtin },
    ["@method"]               = { link = "Function" },
    ["@method.call"]          = { fg = c.func, italic = true },
    ["@string"]               = { link = "String" },
    ["@string.escape"]        = { fg = c.special, bold = true },
    ["@number"]               = { link = "Number" },
    ["@boolean"]              = { link = "Boolean" },
    ["@variable"]             = { fg = c.fg },
    ["@variable.builtin"]     = { fg = c.builtin, italic = true },
    ["@parameter"]            = { fg = c.param },
    ["@type"]                 = { link = "Type" },
    ["@type.builtin"]         = { fg = c.type, italic = true },
    ["@field"]                = { fg = c.field },
    ["@property"]             = { fg = c.field },
    ["@constructor"]          = { fg = c.type },
    ["@operator"]             = { fg = c.operator },
    ["@punctuation.bracket"]  = { fg = c.punct },
    ["@punctuation.delimiter"]= { fg = c.punct },
    ["@tag"]                  = { fg = c.keyword },
    ["@tag.attribute"]        = { fg = c.field },
    ["@tag.delimiter"]        = { fg = c.punct },
    ["@text.title"]           = { fg = c.keyword, bold = true },
    ["@text.strong"]          = { bold = true },
    ["@text.emphasis"]        = { italic = true },
    ["@text.uri"]             = { fg = c.string, underline = true },
    ["@text.todo"]            = { fg = c.bg, bg = c.warn },
  }
end

-- Highlights LSP / diagnostics
function M.lsp(c)
  return {
    DiagnosticError            = { fg = c.error },
    DiagnosticWarn             = { fg = c.warn },
    DiagnosticInfo             = { fg = c.info },
    DiagnosticHint             = { fg = c.hint },
    DiagnosticVirtualTextError = { fg = c.error, bg = c.error_bg },
    DiagnosticVirtualTextWarn  = { fg = c.warn,  bg = c.warn_bg },
    DiagnosticVirtualTextInfo  = { fg = c.info,  bg = c.info_bg },
    DiagnosticVirtualTextHint  = { fg = c.hint,  bg = c.hint_bg },
    DiagnosticUnderlineError   = { undercurl = true, sp = c.error },
    DiagnosticUnderlineWarn    = { undercurl = true, sp = c.warn },
    LspReferenceText           = { bg = c.selection },
    LspReferenceRead           = { bg = c.selection },
    LspReferenceWrite          = { bg = c.selection, bold = true },
  }
end

-- Highlights Telescope
function M.telescope(c)
  return {
    TelescopeNormal          = { fg = c.fg,       bg = c.float_bg },
    TelescopeBorder          = { fg = c.border,   bg = c.float_bg },
    TelescopePromptNormal    = { fg = c.fg,       bg = c.float_bg2 },
    TelescopePromptBorder    = { fg = c.accent,   bg = c.float_bg2 },
    TelescopePromptTitle     = { fg = c.bg,       bg = c.accent,    bold = true },
    TelescopePreviewTitle    = { fg = c.bg,       bg = c.func,      bold = true },
    TelescopeResultsTitle    = { fg = c.float_bg, bg = c.float_bg },
    TelescopeMatching        = { fg = c.accent,   bold = true },
    TelescopeSelection       = { bg = c.selection },
    TelescopeSelectionCaret  = { fg = c.accent },
  }
end

-- Highlights neo-tree
function M.neotree(c)
  return {
    NeoTreeNormal           = { fg = c.fg,      bg = c.sidebar_bg },
    NeoTreeNormalNC         = { fg = c.fg_dim,  bg = c.sidebar_bg },
    NeoTreeRootName         = { fg = c.accent,  bold = true },
    NeoTreeDirectoryName    = { fg = c.fg },
    NeoTreeDirectoryIcon    = { fg = c.accent },
    NeoTreeFileName         = { fg = c.fg_dim },
    NeoTreeFileIcon         = { fg = c.func },
    NeoTreeGitAdded         = { fg = c.git_add },
    NeoTreeGitModified      = { fg = c.git_mod },
    NeoTreeGitDeleted       = { fg = c.error },
    NeoTreeIndentMarker     = { fg = c.border },
    NeoTreeExpander         = { fg = c.border },
    NeoTreeCursorLine       = { bg = c.selection },
  }
end

return M
