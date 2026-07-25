{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    dseg
    ibm-plex
  ];
}
