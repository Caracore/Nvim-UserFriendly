-- colors/cyber.lua
-- Thème Cyber — Cyberpunk neon, sombre et électrique
local U = require("themes.utils")
U.init("cyber")

local c = {
  bg          = "#0d0d1a",
  bg2         = "#12122a",
  fg          = "#cdd6f4",
  fg_dim      = "#7a7fa8",
  keyword     = "#ff2a6d",
  func        = "#05d9e8",
  string      = "#72f1b8",
  number      = "#ff9900",
  type        = "#ad00ff",
  builtin     = "#d6acff",
  field       = "#89dceb",
  param       = "#f38ba8",
  operator    = "#ff2a6d",
  punct       = "#7a7fa8",
  special     = "#f9e2af",
  comment     = "#3d3f6e",
  accent      = "#05d9e8",
  border      = "#2a2a4a",
  selection   = "#1e1e3a",
  float_bg    = "#10102a",
  float_bg2   = "#0d0d22",
  sidebar_bg  = "#0a0a18",
  error       = "#ff2a6d",  warn  = "#ff9900",
  info        = "#05d9e8",  hint  = "#72f1b8",
  error_bg    = "#2d1020",  warn_bg   = "#2d1a08",
  info_bg     = "#08202d",  hint_bg   = "#0a2d1a",
  git_add     = "#72f1b8",  git_mod   = "#ff9900",
}
c.cursorline = c.bg2
c.linenr     = c.comment

U.apply({
  Normal          = { fg = c.fg,      bg = c.bg },
  NormalFloat     = { fg = c.fg,      bg = c.float_bg },
  NormalNC        = { fg = c.fg_dim,  bg = c.bg },
  LineNr          = { fg = c.linenr },
  CursorLine      = { bg = c.cursorline },
  CursorLineNr    = { fg = c.accent,  bold = true },
  SignColumn      = { bg = c.bg },
  ColorColumn     = { bg = c.bg2 },
  VertSplit       = { fg = c.border },
  WinSeparator    = { fg = c.border },
  Pmenu           = { fg = c.fg,      bg = c.float_bg },
  PmenuSel        = { fg = c.bg,      bg = c.accent,  bold = true },
  PmenuSbar       = { bg = c.bg2 },
  PmenuThumb      = { bg = c.accent },
  Search          = { fg = c.bg,      bg = c.accent },
  IncSearch       = { fg = c.bg,      bg = c.keyword, bold = true },
  Visual          = { bg = c.selection },
  MatchParen      = { fg = c.accent,  bold = true, underline = true },
  StatusLine      = { fg = c.fg,      bg = c.bg2 },
  StatusLineNC    = { fg = c.fg_dim,  bg = c.bg2 },
  TabLine         = { fg = c.fg_dim,  bg = c.bg2 },
  TabLineSel      = { fg = c.accent,  bg = c.bg,  bold = true },
  TabLineFill     = { bg = c.bg2 },
  WildMenu        = { fg = c.bg,      bg = c.accent },
  Folded          = { fg = c.comment, bg = c.bg2 },
  FoldColumn      = { fg = c.comment, bg = c.bg },
  Comment         = { fg = c.comment, italic = true },
  Constant        = { fg = c.number },
  String          = { fg = c.string },
  Character       = { fg = c.string },
  Number          = { fg = c.number },
  Boolean         = { fg = c.keyword, bold = true },
  Float           = { fg = c.number },
  Identifier      = { fg = c.fg },
  Function        = { fg = c.func,    bold = true },
  Statement       = { fg = c.keyword },
  Keyword         = { fg = c.keyword, bold = true },
  Operator        = { fg = c.operator },
  Type            = { fg = c.type },
  Special         = { fg = c.special },
  Underlined      = { underline = true },
  Error           = { fg = c.error,   bold = true },
  Todo            = { fg = c.bg,      bg = c.accent, bold = true },
  -- Indent guides / extras
  IndentBlanklineChar             = { fg = c.border },
  IndentBlanklineContextChar      = { fg = c.accent },
  -- Alpha dashboard
  AlphaHeader  = { fg = c.accent },
  AlphaFooter  = { fg = c.comment },
  AlphaButtons = { fg = c.func },
})

U.apply(U.treesitter(c))
U.apply(U.lsp(c))
U.apply(U.telescope(c))
U.apply(U.neotree(c))
