{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Universal editor and shell tooling used across projects.
    git
    ripgrep
    fd
    nixd
    nixfmt
    tree
    tmux
    openssl

    # Desktop applications.
    vesktop
    inkscape
    krita
    codex
    zathura
    signal-desktop
    prismlauncher
  ];
}
