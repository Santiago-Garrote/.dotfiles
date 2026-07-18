{ pkgs, theme, ... }:

let
  colors = theme.colors;
  geometry = theme.geometry;
  typography = theme.typography;
in
{
  xdg.configFile."hypr/hyprland.lua".text = ''
    -- Personal Hyprland Configuration.
    -- Managed declaratively by Home Manager-

    ------------------
    ---- MONITORS ----
    ------------------

    -- Generic fallback for external monitors
    hl.monitor({
      output = "",
      mode = "preferred",
      position = "auto",
      scale = "auto",
    })

    -- Internal laptop display
    hl.monitor({
      output = "eDP-1",
      mode = "preferred",
      position = "0x0",
      scale = 1,
    })

    ----------------------
    ---- APPLICATIONS ----
    ----------------------

    local terminal = "kitty"
    local menu = "hyprlauncher"

    ---------------------
    ---- ENVIRONMENT ----
    ---------------------

    hl.env("XCURSOR_SIZE", "24")
    hl.env("HYPRCURSOR_SIZE", "24")

    ---------------------
    ---- LOOK & FEEL ----
    ---------------------

    hl.config({
      general = {
        gaps_in = ${toString geometry.gapIner},
        gaps_out = ${toString geometry.gapOuter},
        border_size = 2,

        col = {
          active_border = "rgba(${colors.primary}ff)",
          inactive_border = "rgba(${colors.border}ff)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
      },

      decoration = {
        rounding = ${toString geometry.radius},

        active_opacity = 1.0,
        inactive_opacity = 1.0,

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
     },
    })

    ---------------------
    ---- KEYBINDINGS ----
    ---------------------

    local mainMod = "SUPER"

    hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
    hl.bind(mainMod .. " + C", hl.dsp.window.close())
    hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
    hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("power-menu"))
    hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
    hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
    hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
    hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

    -- Workspace navigation
    for i = 1, 10 do
      local key = tostring(i % 10)
      local ws = tostring(i)

      hl.bind(mainMod .. "+" .. key, hl.dsp.focus({ workspace = ws, on_current_monitor = true}))
      hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
    end
  '';
}
