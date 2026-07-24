{ pkgs, theme }:

{
  imports = [
    ./hypridle
    ./hyprpaper
    (import ./mako { inherit pkgs theme; })
  ];
}
