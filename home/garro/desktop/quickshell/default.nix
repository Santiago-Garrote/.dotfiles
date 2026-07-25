{ pkgs, theme }:

{
  imports = [
    (import ./files.nix { inherit pkgs theme; })
    ./package.nix
  ];
}
