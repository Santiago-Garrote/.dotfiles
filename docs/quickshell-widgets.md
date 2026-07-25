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

- Workspace indicator: Hyprland-backed widget showing active desktop state.
- Battery: laptop status widget.
- Wi-Fi bars: network state rendered as geometric signal bars.
- Computer parts performance: CPU, memory, temperature, or disk telemetry.
- Clock: transistor-inspired display, not a generic large clock.
- Mouse position: screen coordinate readout once a reliable pointer data source
  is available.

## Design Rules

- Widgets use `layout/WidgetWindow.qml` for placement.
- Visual primitives live in `components/`.
- Functional widgets live in `widgets/`.
- Shell commands should stay out of visual components.
- Theme values come from `Theme.qml`, generated from the shared Nix theme.
- Widgets must use theme tokens for colors, typography, spacing, borders, and
  radii.
