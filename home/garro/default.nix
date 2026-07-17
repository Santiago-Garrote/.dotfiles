{ ... }:

{
  imports = [
    ./hyprtoolkit.nix
    ./hyprlauncher.nix
    ./hyprland.nix
    ./kitty.nix
    ./waybar.nix
    ./mako.nix
  ];

  home.username = "garro";
  home.homeDirectory = "/home/garro";

  # Keep this value stable after the firs successful activation.
  home.stateVersion = "26.05";

  xdg.enable = true;

  programs.home-manager.enable = true;
  programs.bash.enable = true;

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };
}
