# System Schematic Assets

The laptop schematic SVGs are kept as design assets in `assets/system_widget`.
They are not mounted in the active Quickshell desktop layout.

The current Quickshell desktop layout only shows status widgets that mirror the
same high-level information Waybar exposes: workspace, time, network, and
battery.

## Source Assets

- `assets/system_widget/laptop-assembled-master-v0.svg` is the visual source of
  truth for assembled laptop geometry.
- `assets/system_widget/mockups/storage-exploded.svg` is the approved STORAGE
  selected-state mockup.

The source SVGs use semantic XML IDs for the STORAGE elements that were
previously exported:

- `storage-ssd`
- `storage-socket`
- `storage-activity-led`
- `storage-ssd-label`
- `storage-socket-label`
- `storage-activity-label`
- `pcb-base`
- `chassis-base`

The original `CHASIS_BASE` Inkscape label typo is preserved, but its XML ID is
`chassis-base`.

## Asset Export

The dormant export pipeline can still regenerate standalone schematic assets:

```bash
assets/system_widget/scripts/export-assets.sh
```

The script requires the Inkscape CLI. It writes generated assets only under
`assets/system_widget/runtime` and updates `assets/system_widget/manifest.json`.
It no longer syncs files into `home/garro/widgets/quickshell`, so running the
script does not re-enable the desktop schematic.

## Quickshell Status Layout

Home Manager copies `home/garro/widgets/quickshell` into the deployed
`~/.config/quickshell` tree. Because the active layout no longer imports the
schematic renderer or copies schematic assets, the desktop status widgets are
independent from the exploded schematic experiment.
