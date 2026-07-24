{ ... }:

{
  imports = [
    ./generated.nix
    ./system.nix
  ];
  services.flatpak.enable = true;
}
