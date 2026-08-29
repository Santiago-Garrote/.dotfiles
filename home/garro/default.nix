{ umuPackage, antigravityPackage }:

{ pkgs, ... }:

let
  theme = import ../../themes;
in
{
  imports = [
    ./core
    (import ./desktop { inherit pkgs theme; })
    (import ./programs {
      inherit
        pkgs
        theme
        umuPackage
        antigravityPackage
        ;
    })
    (import ./services { inherit pkgs theme; })
  ];
}
