-- ============================================================
--  NVIM+ Extra : Spotify via playerctl (DBus/MPRIS)
--  Requires: playerctl
--    sudo apt install playerctl
--  Fonctionne avec Spotify desktop (snap ou deb) sans API ni auth.
-- ============================================================

-- Vérifie que playerctl est disponible
local function playerctl(args)
  return vim.fn.jobstart({ "playerctl", "--player=spotify", unpack(args) })
end

-- Récupère la piste en cours (pour la statusline)
local current_track = ""
local timer = nil

local function update_track()
  vim.fn.jobstart(
    { "playerctl", "--player=spotify", "metadata", "--format", "{{status_icon}} {{title}} · {{artist}}" },
    {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data and data[1] and data[1] ~= "" then
          current_track = data[1]
        else
          current_track = ""
        end
      end,
      on_exit = function(_, code)
        if code ~= 0 then current_track = "" end
      end,
    }
  )
end

-- Démarre le timer de mise à jour
local function start_status()
  update_track()
  timer = vim.loop.new_timer()
  timer:start(10000, 10000, vim.schedule_wrap(update_track))
end

-- Expose la fonction pour lualine
_G.SpotifyStatus = function()
  return current_track
end

-- Démarre au chargement si Spotify tourne
vim.defer_fn(function()
  local ok = require("config.user").extras.spotify
  if ok then start_status() end
end, 1000)

-- ── Keymaps (<leader>m = Music) ───────────────────────────────
vim.keymap.set("n", "<leader>mp", function() playerctl({ "play-pause" }) end,       { silent = true, desc = "Spotify : pause/play" })
vim.keymap.set("n", "<leader>mn", function() playerctl({ "next" }) end,             { silent = true, desc = "Spotify : piste suivante" })
vim.keymap.set("n", "<leader>mb", function() playerctl({ "previous" }) end,         { silent = true, desc = "Spotify : piste précédente" })
vim.keymap.set("n", "<leader>mr", function() playerctl({ "shuffle", "toggle" }) end,{ silent = true, desc = "Spotify : aléatoire" })
vim.keymap.set("n", "<leader>m+", function() playerctl({ "volume", "0.1+" }) end,   { silent = true, desc = "Spotify : volume +" })
vim.keymap.set("n", "<leader>m-", function() playerctl({ "volume", "0.1-" }) end,   { silent = true, desc = "Spotify : volume -" })

-- Affiche la piste en cours dans un popup
vim.keymap.set("n", "<leader>mi", function()
  vim.fn.jobstart(
    { "playerctl", "--player=spotify", "metadata", "--format",
      "🎵 {{title}}\n👤 {{artist}}\n💿 {{album}}" },
    {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data and data[1] ~= "" then
          vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = "Spotify" })
        else
          vim.notify("Spotify n'est pas en cours de lecture", vim.log.levels.WARN, { title = "Spotify" })
        end
      end,
    }
  )
end, { silent = true, desc = "Spotify : infos piste" })

return {}
