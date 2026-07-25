{ umuPackage }:

{ pkgs, ... }:

let
  theme = import ../../themes;
in
{
  imports = [
    ./core
    (import ./desktop { inherit pkgs theme; })
    (import ./programs { inherit pkgs theme umuPackage; })
    (import ./services { inherit pkgs theme; })
  ];
}
