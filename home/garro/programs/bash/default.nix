{ pkgs, ... }:

{
  programs.bash.enable = true;

  programs.bash.profileExtra = ''
    if [ -z "''${WAYLAND_DISPLAY:-}" ] && [ "''${XDG_VTNR:-}" = 1 ]; then
      exec ${pkgs.uwsm}/bin/uwsm start hyprland.desktop
    fi
  '';
}
