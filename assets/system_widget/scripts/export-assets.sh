#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
asset_root="$(cd -- "$script_dir/.." && pwd)"
source_svg="$asset_root/laptop-assembled-master-v0.svg"
exploded_svg="$asset_root/mockups/storage-exploded.svg"
runtime_dir="$asset_root/runtime"
storage_dir="$runtime_dir/storage"
manifest="$asset_root/manifest.json"
repo_root="$(cd -- "$asset_root/../.." && pwd)"
quickshell_asset_dir="$repo_root/home/garro/widgets/quickshell/assets/system-schematic"

required_ids=(
  "storage-ssd"
  "storage-socket"
  "storage-activity-led"
  "pcb-base"
  "chassis-base"
)

fail() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

require_file() {
  local path="$1"
  [[ -f "$path" ]] || fail "missing required SVG source: $path"
}

require_id() {
  local svg="$1"
  local id="$2"

  if ! inkscape --query-id="$id" --query-x "$svg" >/dev/null 2>&1; then
    fail "missing semantic SVG id '$id' in $svg"
  fi
}

query_bbox() {
  local svg="$1"
  local id="$2"
  local values

  values="$(inkscape --query-id="$id" --query-x --query-y --query-width --query-height "$svg" 2>/dev/null | awk 'NF { print }')"
  [[ "$(printf '%s\n' "$values" | wc -l)" -eq 4 ]] || fail "could not query bounding box for '$id' in $svg"
  printf '%s\n' "$values"
}

json_bbox() {
  local svg="$1"
  local id="$2"
  local x y width height

  {
    read -r x
    read -r y
    read -r width
    read -r height
  } < <(query_bbox "$svg" "$id")

  printf '{ "x": %s, "y": %s, "width": %s, "height": %s }' "$x" "$y" "$width" "$height"
}

hide_ids_in_svg() {
  local svg="$1"
  shift
  local ids="$*"

  HIDE_IDS="$ids" perl -0pi -e '
    for my $id (split /\s+/, $ENV{"HIDE_IDS"}) {
      s{<([A-Za-z:]+)([^>]*\bid="\Q$id\E"[^>]*)>}{
        my ($tag, $attrs) = ($1, $2);
        if ($attrs =~ /\bstyle="/) {
          $attrs =~ s/\bstyle="/style="display:none;/;
          "<$tag$attrs>";
        } else {
          "<$tag style=\"display:none\"$attrs>";
        }
      }ge;
    }
  ' "$svg"
}

export_id() {
  local svg="$1"
  local id="$2"
  local output="$3"

  inkscape "$svg" \
    --export-id="$id" \
    --export-id-only \
    --export-filename="$output" \
    >/dev/null
}

normalize_svg_metadata() {
  local svg="$1"
  local docname="$2"

  SVG_DOCNAME="$docname" perl -0pi -e 's/sodipodi:docname="[^"]*"/"sodipodi:docname=\"" . $ENV{"SVG_DOCNAME"} . "\""/ge' "$svg"
}

require_file "$source_svg"
require_file "$exploded_svg"

for id in "${required_ids[@]}"; do
  require_id "$source_svg" "$id"
done

require_id "$exploded_svg" "storage-ssd"

rm -rf "$runtime_dir"
mkdir -p "$storage_dir"

base_tmp="$(mktemp --tmpdir system-widget-base.XXXXXX.svg)"
cp "$source_svg" "$base_tmp"
hide_ids_in_svg "$base_tmp" "storage-ssd" "storage-socket" "storage-activity-led"

inkscape "$base_tmp" --export-filename="$runtime_dir/base.svg" >/dev/null
normalize_svg_metadata "$runtime_dir/base.svg" "base.svg"
rm -f "$base_tmp"

export_id "$source_svg" "storage-ssd" "$storage_dir/ssd.svg"
export_id "$source_svg" "storage-socket" "$storage_dir/socket.svg"
export_id "$source_svg" "storage-activity-led" "$storage_dir/activity-led.svg"

cat >"$manifest" <<EOF
{
  "system": "storage",
  "source": {
    "assembled": "laptop-assembled-master-v0.svg",
    "explodedReference": "mockups/storage-exploded.svg"
  },
  "document": {
    "coordinateSpace": "inkscape-query-px",
    "alignment": "cropped-assets-with-manifest-offsets",
    "width": 1299,
    "height": 860
  },
  "assets": {
    "base": "runtime/base.svg",
    "ssd": "runtime/storage/ssd.svg",
    "socket": "runtime/storage/socket.svg",
    "activityLed": "runtime/storage/activity-led.svg"
  },
  "storage": {
    "primaryAsset": "ssd",
    "relatedAssets": ["socket", "activityLed"],
    "assembled": {
      "ssd": $(json_bbox "$source_svg" "storage-ssd"),
      "socket": $(json_bbox "$source_svg" "storage-socket"),
      "activityLed": $(json_bbox "$source_svg" "storage-activity-led")
    },
    "exploded": {
      "ssd": $(json_bbox "$exploded_svg" "storage-ssd"),
      "rotation": 0,
      "scale": 1
    },
    "zOrder": {
      "base": 0,
      "socket": 10,
      "activityLed": 20,
      "ssd": 30,
      "overlay": 40
    },
    "hitArea": $(json_bbox "$source_svg" "storage-ssd"),
    "callout": {
      "x": 724,
      "y": 94,
      "width": 360,
      "height": 270
    }
  }
}
EOF

for output in "$runtime_dir/base.svg" "$storage_dir/ssd.svg" "$storage_dir/socket.svg" "$storage_dir/activity-led.svg" "$manifest"; do
  [[ -s "$output" ]] || fail "expected generated file is empty or missing: $output"
done

rm -rf "$quickshell_asset_dir"
mkdir -p "$quickshell_asset_dir"
cp -r "$runtime_dir" "$quickshell_asset_dir/runtime"
cp "$manifest" "$quickshell_asset_dir/manifest.json"

printf 'Generated storage schematic assets in %s\n' "$runtime_dir"
printf 'Generated manifest at %s\n' "$manifest"
printf 'Synced Quickshell development assets to %s\n' "$quickshell_asset_dir"
