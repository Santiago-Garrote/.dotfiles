{ theme, ... }:

let
  colors = theme.colors;
  geometry = theme.geometry;
  typography = theme.typography;
in
{
  programs.kitty = {
    enable = true;

    font = {
      name = typography.monospace;
      size = 11;
    };

    settings = {
      window_padding_width = geometry.spacingMedium;

      background = "#${colors.background}";
      foreground = "#${colors.foreground}";

      cursor = "#${colors.accent}";
      cursor_text_color = "#${colors.onPrimary}";

      selection_background = "#${colors.selection}";
      selection_foreground = "#${colors.onSelection}";

      url_color = "#${colors.accent}";

      active_border_color = "#${colors.accent}";
      inactive_border_color = "#${colors.border}";
      bell_border_color = "#${colors.error}";
    };
  };
}
