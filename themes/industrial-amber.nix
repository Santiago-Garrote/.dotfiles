let
  base = import ./base.nix;
  palette = import ../palettes/industrial-amber.nix;
in
base
// {
  name = "industrial-amber";

  colors = {
    background = palette.neutral950;
    surface = palette.neutral900;
    border = palette.neutral700;

    text = palette.neutral200;
    textMuted = palette.neutral950;

    primary = palette.amber500;
    onPrimary = palette.neutral950;

    accent = palette.amber500;

    selection = palette.neutral700;
    onSelection = palette.neutral200;

    success = palette.green500;
    warning = palette.amber500;

    error = palette.red500;
    onError = palette.neutral950;
  };
}
