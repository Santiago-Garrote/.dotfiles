{ pkgs, theme }:

{
  imports = [
    ./hypridle
    ./hyprpaper
    ./blueman
    (import ./mako { inherit pkgs theme; })
  ];
}
