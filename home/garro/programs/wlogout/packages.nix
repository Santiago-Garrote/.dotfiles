{ pkgs, scripts }:

{
  home.packages = [
    scripts.powerMenu

    # Useful for manually testing its confirmation screen.
    pkgs.hyprshutdown
  ];
}
