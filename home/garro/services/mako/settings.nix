{ theme }:

let
  color = value: "#${value}FF";
  colors = theme.colors;
  geometry = theme.geometry;
  typography = theme.typography;
in
{
  services.mako.settings = {
    anchor = "top-right";
    layer = "overlay";

    width = 340;
    height = 100;

    outer-margin = geometry.gapOuter;
    margin = geometry.gapInner;
    padding = geometry.spacingMedium;

    border-size = geometry.borderWidth;
    border-radius = geometry.radius;

    background-color = color colors.surface;
    text-color = color colors.foreground;
    border-color = color colors.border;

    progress-color = "over ${color colors.accent}";

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
}
