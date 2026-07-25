{ theme, ... }:
let
  colors = theme.colors;
  typography = theme.typography;
in
{
  xdg.configFile."hypr/hyprtoolkit.conf".text = ''
    background = 0xFF${colors.background}
    base = 0xFF${colors.surface}
    alternate_base = 0xFF${colors.border}

    text = 0xFF${colors.foreground}
    bright_text = 0xFF${colors.accent}

    accent = 0xFF${colors.accent}
    accent_secondary = 0xFF${colors.success}

    h1_size = 17
    h2_size = 14
    h3_size = 12
    font_size = 11
    small_font_size = 10

    font_family = ${typography.interface}
    font_family_monospace = ${typography.monospace}
  '';
}
