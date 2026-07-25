{ pkgs, theme }:

{
  imports = [
    ./appearance
    (import ./gtk { inherit theme; })
    ./hyprlauncher
    (import ./hyprland { inherit theme; })
    (import ./hyprtoolkit { inherit theme; })
    (import ./qt { inherit theme; })
    (import ./quickshell { inherit pkgs theme; })
    ./uwsm
    (import ./waybar { inherit theme; })
  ];
}
