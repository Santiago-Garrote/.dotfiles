{ pkgs, theme, ... }:

let
  scripts = import ./scripts.nix { inherit pkgs; };
in
{
  imports = [
    (import ./layout.nix { inherit pkgs scripts; })
    (import ./packages.nix { inherit pkgs scripts; })
    (import ./style.nix { inherit theme; })
  ];

  programs.wlogout.enable = true;
}
