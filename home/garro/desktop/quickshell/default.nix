{ theme }:

{
  imports = [
    ./files.nix
    ./package.nix
    (import ./theme.nix { inherit theme; })
  ];
}
