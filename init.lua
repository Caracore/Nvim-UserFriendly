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

-- Wildmenu — complétion native enrichie (fallback si cmp non actif)
vim.opt.wildmenu       = true
vim.opt.wildmode       = "longest:full,full"  -- complète le plus long, puis liste tout
vim.opt.wildoptions    = "pum"                -- popup menu au lieu de la barre du bas
vim.opt.pumheight      = 15                   -- hauteur max du popup

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

-- ── Keymaps édition mode visuel ──────────────────────────────────────────
-- Déplacer une sélection vers le haut / bas
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Déplacer sélection bas",  silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Déplacer sélection haut", silent = true })
-- Rester en mode visuel après indentation
vim.keymap.set("v", "<",     "<gv",               { desc = "Désindenter",             silent = true })
vim.keymap.set("v", ">",     ">gv",               { desc = "Indenter",                silent = true })
-- Coller sans écraser le registre (le texte collé repart dans _)
vim.keymap.set("x", "p",     '"_dP',              { desc = "Coller (sans polluer registre)", silent = true })

-- ── Créer fichier / dossier ───────────────────────────────────────────────
local function create_file()
  vim.ui.input({ prompt = "Nouveau fichier : ", default = vim.fn.expand("%:h") .. "/" }, function(path)
    if not path or path == "" then return end
    -- Créer les dossiers parents si nécessaire
    local dir = vim.fn.fnamemodify(path, ":h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
    if vim.fn.filereadable(path) == 1 then
      vim.notify("Fichier déjà existant : " .. path, vim.log.levels.WARN)
    else
      vim.fn.writefile({}, path)
      vim.notify("Fichier créé : " .. path, vim.log.levels.INFO)
    end
    vim.cmd("edit " .. vim.fn.fnameescape(path))
  end)
end

local function create_dir()
  vim.ui.input({ prompt = "Nouveau dossier : ", default = vim.fn.expand("%:h") .. "/" }, function(path)
    if not path or path == "" then return end
    -- Retirer le slash final s'il y en a un (pour l'affichage propre)
    path = path:gsub("/$", "")
    if vim.fn.isdirectory(path) == 1 then
      vim.notify("Dossier déjà existant : " .. path, vim.log.levels.WARN)
    else
      vim.fn.mkdir(path, "p")
      vim.notify("Dossier créé : " .. path, vim.log.levels.INFO)
    end
    -- Rafraîchir Neo-tree si ouvert
    pcall(function() require("neo-tree.sources.manager").refresh("filesystem") end)
  end)
end

vim.keymap.set("n", "<leader>nf", create_file, { desc = "Nouveau fichier", silent = true })
vim.keymap.set("n", "<leader>nd", create_dir,  { desc = "Nouveau dossier", silent = true })

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
      io.write("\a")
      io.flush()
    elseif S.sound == "system" then
      local file = S.sound_file or "/usr/share/sounds/freedesktop/stereo/complete.oga"
      if vim.fn.filereadable(file) == 1 then
        if vim.fn.executable("paplay") == 1 then
          vim.fn.jobstart({ "paplay", file })
        elseif vim.fn.executable("pw-play") == 1 then
          vim.fn.jobstart({ "pw-play", file })
        elseif vim.fn.executable("aplay") == 1 then
          vim.fn.jobstart({ "aplay", "-q", file })
        end
      else
        io.write("\a") io.flush()  -- fallback bell si fichier introuvable
      end
    end
  end,
})

-- ── g + chiffres → aller à la ligne ──────────────────────────────────────
-- Exemples : g1  g42  g100
-- Les touches g0-g9 captent le premier chiffre, puis accumulent les suivants.
for i = 0, 9 do
  vim.keymap.set("n", "g" .. i, function()
    local num = tostring(i)
    -- Affiche le numéro composé en bas
    vim.api.nvim_echo({ { "goto: " .. num, "MoreMsg" } }, false, {})
    while true do
      local ok, ch = pcall(vim.fn.getchar)
      if not ok then break end
      local c = type(ch) == "number" and vim.fn.nr2char(ch) or ch
      if c:match("%d") then
        num = num .. c
        vim.api.nvim_echo({ { "goto: " .. num, "MoreMsg" } }, false, {})
      else
        break
      end
    end
    vim.api.nvim_echo({ { "", "Normal" } }, false, {})
    local line = tonumber(num)
    if line then
      local max = vim.api.nvim_buf_line_count(0)
      vim.api.nvim_win_set_cursor(0, { math.min(line, max), 0 })
    end
  end, { desc = "Goto ligne " .. i .. "…" })
end
