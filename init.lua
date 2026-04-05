-- Leader key (doit être défini AVANT lazy.nvim)
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Désactive netrw (on utilise neo-tree + telescope)
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Charge les options depuis user.lua
local U = require("config.user")
local E = U.editor

vim.opt.number         = E.line_numbers
vim.opt.relativenumber = E.relative_nums
vim.opt.tabstop        = E.tab_size
vim.opt.shiftwidth     = E.tab_size
vim.opt.expandtab      = true
vim.opt.wrap           = E.wrap
vim.opt.scrolloff      = E.scroll_off
vim.opt.termguicolors  = true
vim.opt.signcolumn     = "yes"
vim.opt.cmdheight      = 1  -- 0 cause des glitches avec which-key/noice

-- Curseur
local cursor_map = { block = "block", line = "ver25", underline = "hor20" }
vim.opt.guicursor = "n-v-c:" .. (cursor_map[U.cursor.style] or "block")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = { notify = false },
})

-- Keymaps APRÈS le chargement des plugins
for _, km in ipairs(U.keymaps) do
  vim.keymap.set("n", km[1], km[2], { desc = km[3], silent = true })
end
