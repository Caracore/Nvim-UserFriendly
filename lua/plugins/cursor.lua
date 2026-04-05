return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",  -- charge après le démarrage, pas d'impact sur le boot
    opts = function()
      local C = require("config.user").cursor.smear

      if not C.enabled then
        return { enabled = false }
      end

      return {
        stiffness                        = C.stiffness,
        trailing_stiffness               = C.trailing_stiffness,
        distance_stop_animating          = C.distance_stop_animating,
        hide_target_hack                 = C.hide_target,
        legacy_computing_symbols_support = C.legacy_computing,

        -- Couleur : "auto" laisse smear-cursor choisir selon le colorscheme
        cursor_color = C.color ~= "auto" and C.color or nil,
      }
    end,
  },
}
