{ pkgs, theme, ... }:
let
  color = value: "#${value}FF";
  colors = theme.colors;
  geometry = theme.geometry;
  typography = theme.typography;
in
{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      layer = "overlay";

      width = 340;
      height = 100;

      outer-margin = geometry.gapOuter;
      margin = geometry.gapIner;
      padding = geometry.spacingMedium;

      border-size = geometry.borderWidth;
      border-radius = geometry.radius;

      background-color = color colors.surface;
      text-color = color colors.text;
      border-color = color colors.border;

      progress-color = "over ${color colors.primary}";

      font = "${typography.interface} 10";
      text-alignment = "left";

      icons = true;
      max-icon-size = 32;
      icon-location = "left";
      icon-border-radius = 0;

      markup = true;
      actions = true;

      format = "<b>%s</b>\\n%b";

      default-timeout = 6000;
      ignore-timeout = false;

      max-visible = 4;
      max-history = 10;

      group-by = "app-name";
      sort = "-time";
    };

    # Criteria order matters in Mako, so these rules remain explicit.
    extraConfig = ''
      [urgency=low]
      border-color=${color colors.border}
      text-color=${color colors.textMuted}
      default-timeout=4000

      [urgency=normal]
      border-color=${color colors.primary}

      [urgency=critical]
      background-color=${color colors.error}
      text-color=${color colors.onError}
      border-color=${color colors.error}
      default-timeout=0
    '';
  };

  # Provides notify-send for testing and future scripts
  home.packages = [
    pkgs.libnotify
  ];
}
