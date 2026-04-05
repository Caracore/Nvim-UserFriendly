-- ============================================================
--  NVIM+ Extra : nvim-spotify
--  Requires:
--    - spotify-tui (spt)  → https://github.com/Rigellute/spotify-tui
--    - golang             → https://go.dev/doc/install
--  Installation de spotify-tui :
--    cargo install spotify-tui   (nécessite Rust)
--    ou : snap install spt
--  Première utilisation : spt  (authentification Spotify)
-- ============================================================
return {
  {
    "KadoBOT/nvim-spotify",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cond  = function() return require("config.user").extras.spotify end,
    build = "make",
    config = function()
      local spotify = require("nvim-spotify")

      spotify.setup({
        status = {
          -- Intervalle de rafraîchissement (ms). Ne pas descendre sous 5000
          -- pour éviter le rate-limiting de l'API Spotify.
          update_interval = 10000,
          -- Format : %s = état (▶/⏸), %t = titre, %a = artiste, %b = album
          format = "%s %t by %a",
        },
      })

      -- ── Keymaps Spotify (<leader>m = Music) ───────────────────────
      local map = function(key, plug, desc)
        vim.keymap.set("n", "<leader>m" .. key, plug, { silent = true, desc = desc })
      end

      map("o", "<cmd>Spotify<CR>",               "Spotify : rechercher")
      map("d", "<cmd>SpotifyDevices<CR>",         "Spotify : choisir device")
      map("p", "<Plug>(SpotifyPause)",            "Spotify : pause/play")
      map("n", "<Plug>(SpotifySkip)",             "Spotify : piste suivante")
      map("b", "<Plug>(SpotifyPrev)",             "Spotify : piste précédente")
      map("s", "<Plug>(SpotifySave)",             "Spotify : sauvegarder piste")
      map("r", "<Plug>(SpotifyShuffle)",          "Spotify : aléatoire")
    end,
  },
}
