{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
    inkscape
    krita
    signal-desktop
    prismlauncher
  ];
}
