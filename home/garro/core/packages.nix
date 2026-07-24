{ pkgs, ... }:

{
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
