{ pkgs, theme, ... }:

{
  imports = [
    (import ./criteria.nix { inherit theme; })
    (import ./packages.nix { inherit pkgs; })
    (import ./settings.nix { inherit theme; })
  ];

  services.mako.enable = true;
}
