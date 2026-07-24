{
  theme,
  ...
}:

{
  imports = [
    ./settings.nix
    (import ./style.nix { inherit theme; })
  ];

  programs.waybar.enable = true;

  # Home Manager starts Waybar through the user systemd unit.
  programs.waybar.systemd.enable = true;
}
