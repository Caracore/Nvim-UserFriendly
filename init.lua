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

-- Ctrl+S en insertion et visuel (write sans quitter le mode)
vim.keymap.set("i", "<C-s>", "<cmd>write<cr>", { desc = "Sauvegarder", silent = true })
vim.keymap.set("v", "<C-s>", "<cmd>write<cr>", { desc = "Sauvegarder", silent = true })

-- Notification + son après chaque sauvegarde
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    local S = U.save

    -- Notification visuelle
    if S.notify then
      local fname = vim.fn.expand("%:t")
      vim.notify(
        "  " .. fname .. " sauvegardé",
        vim.log.levels.INFO,
        { title = "Sauvegarde", timeout = 1500 }
      )
    end

    -- Son
    if S.sound == "bell" then
      io.write("\a")          -- bip terminal universel
      io.flush()
    elseif S.sound == "system" then
      local sounds = {
        "/usr/share/sounds/freedesktop/stereo/message.oga",
        "/usr/share/sounds/freedesktop/stereo/bell.oga",
        "/usr/share/sounds/sound-icons/message.wav",
      }
      if vim.fn.executable("paplay") == 1 then
        for _, f in ipairs(sounds) do
          if vim.fn.filereadable(f) == 1 then
            vim.fn.system("paplay " .. f .. " &")
            break
          end
        end
      elseif vim.fn.executable("aplay") == 1 then
        for _, f in ipairs(sounds) do
          if vim.fn.filereadable(f) == 1 then
            vim.fn.system("aplay -q " .. f .. " &")
            break
          end
        end
      else
        io.write("\a") io.flush()   -- fallback bell
      end
    end
  end,
})
