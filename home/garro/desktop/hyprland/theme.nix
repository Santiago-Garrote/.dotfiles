{ theme, ... }:

let
  colors = theme.colors;
  geometry = theme.geometry;
in
''
  ---------------------
  ---- LOOK & FEEL ----
  ---------------------

  -- Industrial Amber window treatment
  hl.config({
    general = {
      gaps_in = ${toString geometry.gapInner},
      gaps_out = ${toString geometry.gapOuter},
      border_size = ${toString geometry.borderWidth},
      layout = "dwindle",

      col = {
        active_border = "rgba(${colors.accent}ff)",
        inactive_border = "rgba(${colors.border}ff)",
      },

      resize_on_border = true,
      extend_border_grab_area = 8,
      allow_tearing = false,
    },

    decoration = {
      rounding = ${toString geometry.radius},

      active_opacity = 1.0,
      inactive_opacity = 0.98,
      fullscreen_opacity = 1.0,

      dim_inactive = false,

      shadow = {
        enabled = false,
      },

      blur = {
        enabled = false,
      },
    },

    animations = {
      enabled = ${if theme.motion.enabled then "true" else "false"},
    },

    dwindle = {
      preserve_split = true,
    },

    input = {
      kb_layout = "latam",
      kb_variant = "",
      kb_model = "",
      kb_options = "",
      kb_rules = "",

      follow_mouse = 1,
      sensitivity = 0,

      touchpad = {
        natural_scroll = false,
      },
    },

    misc = {
      force_default_wallpaper = 0,
      disable_hyprland_logo = true,
      disable_splash_rendering = true,

      font_family = "${theme.typography.interface}",
    },
  })
''
