{ umuPackage }:

{ pkgs, ... }:

let
  theme = import ../../themes;
in
{
  imports = [
    ./appearance.nix
    (import ./qt.nix { inherit theme; })
    (import ./gtk.nix { inherit theme; })
    ./uwsm.nix
    (import ./quickshell.nix { inherit theme; })
    ./programs/neovim

    (import ./hyprtoolkit.nix { inherit theme; })
    ./hyprlauncher.nix
    (import ./mako.nix { inherit pkgs theme; })
    ./hyprpaper.nix
    (import ./hyprlock.nix { inherit theme; })
    ./hypridle.nix
    (import ./wlogout.nix { inherit pkgs theme; })
    (import ./hyprland.nix { inherit theme; })
    (import ./kitty.nix { inherit theme; })
    (import ./waybar.nix { inherit theme; })
  ];

  home.username = "garro";
  home.homeDirectory = "/home/garro";

  # Keep this value stable after the firs successful activation.
  home.stateVersion = "26.05";

  xdg.enable = true;

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.firefox.enable = true;
  programs.lutris = {
    enable = true;

    extraPackages = with pkgs; [
      winetricks
      umuPackage
      vulkan-tools
    ];

    winePackages = with pkgs; [
      wineWow64Packages.stableFull
    ];

    protonPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };

  home.packages = with pkgs; [
    # Universal editor and shell tooling used across projects.
    git
    ripgrep
    fd
    nixd
    nixfmt-rfc-style

    inkscape
    krita
    codex
  ];
}
