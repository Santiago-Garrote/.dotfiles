let
  base = import ./base.nix;
  palette = import ../palettes/phosphor-green.nix;
in
base
// {
  name = "phosphor-green";

  colors = {
    background = palette.neutral950;
    surface = palette.neutral900;
    border = palette.neutral700;

    text = palette.neutral200;
    textMuted = palette.neutral500;

    primary = palette.green500;
    onPrimary = palette.neutral950;

    accent = palette.green500;

    selection = palette.neutral700;
    onSelection = palette.neutral200;

    success = palette.green500;
    warning = palette.amber500;

    error = palette.red500;
    onError = palette.neutral950;
  };
}
