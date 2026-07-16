{ ... }:

{
  imports = [
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
}
