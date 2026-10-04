{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Amber";
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };
}
