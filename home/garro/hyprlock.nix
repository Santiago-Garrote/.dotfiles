{ theme, ... }:

let
  wallpaper = ../../assets/wallpapers/industrial-amber.png;
  colors = theme.colors;
  rgb = value: "rgb(${value})";
  rgba = value: alpha: "rgba(${value}${alpha})";
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_curson = true;
        ignore_empty_input = true;
        immediate_render = true;
      };

      background = [
        {
          monitor = "eDP-1";
          path = "${wallpaper}";

          color = rgb colors.background;
          blur_passes = 0;
          brightness = 0.68;
        }
      ];

      "input-field" = [
        {
          monitor = "eDP-1";

          size = "320, 52";
          position = "0, -80";

          halign = "center";
          valign = "center";

          outline_thickness = theme.geometry.borderWidth;
          rounding = theme.geometry.radius;

          dots_size = 0.18;
          dots_spacing = 0.28;
          dots_center = true;

          fade_on_empty = false;

          inner_color = rgba theme.colors.surface "E6";
          outer_color = rgb theme.colors.primary;
          font_color = rgb theme.colors.text;

          check_color = rgb theme.colors.success;
          fail_color = rgb theme.colors.error;
          capslock_color = rgb theme.colors.warning;

          placeholder_text = "AUTHENTICATE_";
          check_text = "VERIFYING_";
          fail_text = "$FAIL // ATTEMPT $ATTEMPTS";

          font_family = theme.typography.monospace;
        }
      ];
      label = [
        {
          monitor = "eDP-1";

          text = "SESSION // LOCKED";
          color = rgb theme.colors.primary;

          font_size = 13;
          font_family = theme.typography.monospace;

          position = "24, -18";
          halign = "left";
          valign = "top";
        }

        {
          monitor = "eDP-1";

          text = "$TIME";
          color = rgb theme.colors.text;

          font_size = 64;
          font_family = theme.typography.monospace;

          position = "0, 75";
          halign = "center";
          valign = "center";
        }

        {
          monitor = "eDP-1";

          text = "$USER";
          color = rgb theme.colors.textMuted;

          font_size = 14;
          font_family = theme.typography.monospace;

          position = "0, 18";
          halign = "center";
          valign = "center";
        }

        {
          monitor = "eDP-1";

          text = "ESC CLEAR // ENTER AUTH";
          color = rgb theme.colors.textMuted;

          font_size = 11;
          font_family = theme.typography.monospace;

          position = "-24, 18";
          halign = "right";
          valign = "bottom";
        }
      ];
    };
  };
}
