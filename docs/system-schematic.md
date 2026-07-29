# Interactive System Schematic

The system schematic is a Quickshell desktop widget that renders a laptop
hardware drawing below normal application windows. The first vertical slice only
implements the `STORAGE` system: the SSD can be selected, animated into the
approved exploded position, and paired with live root filesystem storage data.

## Source Assets

The source SVGs live in `assets/system_widget`:

- `laptop-assembled-master-v0.svg` is the visual source of truth for assembled
  geometry.
- `mockups/storage-exploded.svg` is the STORAGE selected-state composition
  reference.

The runtime does not replace the full screen with the exploded mockup. It uses
the mockup only to derive the final SSD bounding box stored in the manifest.

The STORAGE slice relies on stable semantic XML IDs:

- `storage-ssd`
- `storage-socket`
- `storage-activity-led`
- `pcb-base`
- `chassis-base`

The original Inkscape labels were already semantic for the active storage
objects. The XML IDs were normalized from generated IDs. The existing
`CHASIS_BASE` label typo was left unchanged, but its XML ID is `chassis-base`.

## Asset Export

Regenerate runtime assets from the repository root:

```bash
assets/system_widget/scripts/export-assets.sh
```

The script requires the Inkscape CLI. It checks source files, checks semantic
IDs, exports cropped SVG layers for the SSD, socket, and activity indicator, and
generates `assets/system_widget/manifest.json`.

Runtime assets:

- `assets/system_widget/runtime/base.svg`
- `assets/system_widget/runtime/storage/ssd.svg`
- `assets/system_widget/runtime/storage/socket.svg`
- `assets/system_widget/runtime/storage/activity-led.svg`
- `assets/system_widget/manifest.json`

The current renderer uses cropped assets plus explicit offsets from the
manifest. This is lighter than full-canvas transparent layers, but it requires
the manifest to stay in sync with exported geometry. The export script owns that
synchronization.

## Quickshell Integration

Home Manager copies the Quickshell source tree into `~/.config/quickshell`.
The module also copies the generated schematic runtime assets and manifest into
`~/.config/quickshell/assets/system-schematic`.

The widget is composed from four focused parts:

- `StorageDataProvider.qml` discovers the root-backed physical block device and
  reads metrics.
- `StorageInteractionController.qml` owns `ASSEMBLED` and
  `STORAGE_SELECTED`.
- `SchematicRenderer.qml` draws the SVG layers and applies visual state.
- `StorageInfoOverlay.qml` displays labels, values, units, and `N/A`
  fallbacks.

`layout/WidgetWindow.qml` supplies the background layer-shell behavior. The
schematic sets an input `Region` for the SSD hit area and the selected callout,
so the whole transparent window is not a permanent click blocker.

## Storage Discovery And Metrics

The provider does not hardcode `/dev/nvme0n1`, `/dev/sda`, or a partition name.
It runs:

- `lsblk -J -b -o NAME,PATH,TYPE,MODEL,SIZE,FSTYPE,MOUNTPOINT` to find the
  block-device tree containing mount point `/` and then selects the closest
  physical `disk` in that ancestry.
- `df -B1 -P /` for root filesystem capacity, used bytes, available bytes, and
  usage percentage.
- `/proc/diskstats` for read/write activity on the selected physical device.
- `/sys/class/block/<device>/device/hwmon/hwmon*/temp*_input` for temperature
  when readable without privileges.
- `/sys/class/block/<device>/device/state` for a conservative health/status
  string when available.

Unavailable values render as `N/A`. Optional temperature and health failures do
not disable the schematic.

## Polling Policy

When assembled, detailed storage discovery and filesystem usage update
conservatively. Disk activity reads `/proc/diskstats` every 2.5 seconds for the
small LED indicator without spawning a process.

When STORAGE is selected:

- root filesystem usage updates every 5 seconds;
- disk activity updates every 1 second;
- temperature and health update every 60 seconds;
- model/path discovery remains at a 30 second interval.

## Interaction

In `ASSEMBLED`, the complete schematic is visible, the SSD has a subtle amber
hover frame, and only the SSD input region accepts pointer events.

In `STORAGE_SELECTED`, the SSD animates from its assembled bounding box to the
SSD bounding box derived from `mockups/storage-exploded.svg`. The socket and
storage activity indicator remain sharp at their assembled locations, unrelated
hardware is dimmed with opacity, and the storage information overlay appears.
Clicking the SSD again returns to `ASSEMBLED` without restarting Quickshell.

Click-outside dismissal is intentionally not implemented in this slice because
it would require a broader input region and would conflict with desktop
click-through behavior. Escape dismissal is also omitted because the background
layer is not keyboard-focusable.

## Launch And Test

Run the checked-in Quickshell tree directly:

```bash
quickshell --path home/garro/widgets/quickshell
```

After Home Manager activation, run the deployed config:

```bash
quickshell
```

The renderer is SVG-based. A future renderer could replace `SchematicRenderer`
with Canvas, Qt Quick Shapes, or a scene graph item while preserving the same
manifest, data provider, controller, and overlay boundaries.
