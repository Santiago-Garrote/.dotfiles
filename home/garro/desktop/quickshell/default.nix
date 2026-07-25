{ theme }:

{
  imports = [
    ./files.nix
    ./package.nix
    ./service.nix
    (import ./theme.nix { inherit theme; })
  ];
}
