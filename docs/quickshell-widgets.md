# Quickshell Widget Plan

Quickshell is the future desktop widget layer. It should not recreate Waybar as
a second bar.

## Current Waybar Surface

Waybar currently owns:

- Hyprland workspaces.
- Clock.
- Network status.
- Battery status.

## Migration Order

1. Keep Waybar as the reliable temporary bar.
2. Build Quickshell widgets as manually launched previews.
3. Move one information surface at a time from Waybar to Quickshell.
4. Remove the matching Waybar module only after the Quickshell widget is useful
   and stable.
5. Add Quickshell autostart only after the widget layer has a clear desktop
   layout and no longer behaves like a bar.

## Candidate Widgets

- Workspaces: first candidate for Hyprland integration, once the repository has
  a reliable data source for workspace state.
- Media: current MPRIS-backed widget, useful when a media player is active.
- Battery: useful laptop widget, should come before removing Waybar battery.
- Network: useful but should handle disconnected, wired, and Wi-Fi states
  explicitly.
- Clock: useful as a layout smoke test, but not final visual direction.

## Design Rules

- Widgets use `layout/WidgetWindow.qml` for placement.
- Visual primitives live in `components/`.
- Functional widgets live in `widgets/`.
- Shell commands should stay out of visual components.
- Theme values come from `Theme.qml`, generated from the shared Nix theme.
