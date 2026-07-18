{ ... }:

{
  imports = [
    ./appearance.nix
    ./qt.nix
    ./gtk.nix
    ./uwsm.nix

    ./hyprtoolkit.nix
    ./hyprlauncher.nix
    ./mako.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./wlogout.nix
    ./hyprland.nix
    ./kitty.nix
    ./waybar.nix
  ];

  home.username = "garro";
  home.homeDirectory = "/home/garro";

  # Keep this value stable after the firs successful activation.
  home.stateVersion = "26.05";

  xdg.enable = true;

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.firefox.enable = true;

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };
}
