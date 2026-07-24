{ pkgs }:

{
  # Provides notify-send for testing and future scripts.
  home.packages = [
    pkgs.libnotify
  ];
}
