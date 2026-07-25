# Session Services

This repository avoids starting the same desktop process from multiple places.

## Current Ownership

- Hyprland owns compositor configuration, environment variables, window rules,
  and keybindings.
- Waybar is started by Home Manager through its user systemd integration.
- Hyprpaper and Hypridle are started by their Home Manager service modules.
- Mako is configured by Home Manager and started through DBus activation when a
  notification service is requested.
- Quickshell is installed and configured, but it is not started automatically.

## Quickshell Direction

Quickshell should provide desktop widgets, not a second bar. Waybar remains the
temporary bar until its information is moved into desktop widgets.

The migration order is tracked in `docs/quickshell-widgets.md`.

Do not add a Quickshell user service or Hyprland `exec-once` entry unless the
configuration no longer creates a bar and the desired widget startup behavior is
explicit.
