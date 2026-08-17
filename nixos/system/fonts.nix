{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    dseg
    nerd-fonts.blex-mono
    ibm-plex
  ];
}
