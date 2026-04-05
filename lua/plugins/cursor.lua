return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = function()
      local C = require("config.user").cursor.smear

      if not C.enabled then
        return { enabled = false }
      end

      -- Presets
      local presets = {

        default = {
          stiffness                        = 0.3,
          trailing_stiffness               = 0.15,
          distance_stop_animating          = 0.5,
          hide_target_hack                 = C.hide_target,
          legacy_computing_symbols_support = C.legacy_computing,
        },

        fast = {
          stiffness                        = 0.8,
          trailing_stiffness               = 0.6,
          stiffness_insert_mode            = 0.7,
          trailing_stiffness_insert_mode   = 0.7,
          damping                          = 0.95,
          damping_insert_mode              = 0.95,
          distance_stop_animating          = 0.5,
          hide_target_hack                 = C.hide_target,
          legacy_computing_symbols_support = C.legacy_computing,
        },

        smooth = {
          stiffness                        = 0.5,
          trailing_stiffness               = 0.5,
          matrix_pixel_threshold           = 0.5,
          hide_target_hack                 = C.hide_target,
          legacy_computing_symbols_support = C.legacy_computing,
        },

        -- 🔥 Fire Hazard — config officielle du repo smear-cursor
        fire = {
          cursor_color                     = "#ff4000",
          particles_enabled                = true,
          stiffness                        = 0.5,
          trailing_stiffness               = 0.2,
          trailing_exponent                = 5,
          damping                          = 0.6,
          gradient_exponent                = 0,
          gamma                            = 1,
          never_draw_over_target           = true,
          hide_target_hack                 = true,
          particle_spread                  = 1,
          particles_per_second             = 500,
          particles_per_length             = 50,
          particle_max_lifetime            = 800,
          particle_max_initial_velocity    = 20,
          particle_velocity_from_cursor    = 0.5,
          particle_damping                 = 0.15,
          particle_gravity                 = -50,
          min_distance_emit_particles      = 0,
          legacy_computing_symbols_support = C.legacy_computing,
        },
      }

      local cfg = presets[C.preset] or presets.default

      -- Couleur personnalisée (écrase le preset sauf pour fire)
      if C.preset ~= "fire" and C.color ~= "auto" then
        cfg.cursor_color = C.color
      end

      return cfg
    end,
  },
}
