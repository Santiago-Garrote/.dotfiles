#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
asset_root="$(cd -- "$script_dir/.." && pwd)"
source_svg="$asset_root/laptop-assembled-master-v0.svg"
exploded_svg="$asset_root/mockups/storage-exploded.svg"
runtime_dir="$asset_root/runtime"
storage_dir="$runtime_dir/storage"
manifest="$asset_root/manifest.json"

required_ids=(
  "storage-ssd"
  "storage-socket"
  "storage-activity-led"
  "pcb-base"
  "chassis-base"
)

exploded_required_ids=(
  "storage-ssd"
  "storage-socket"
  "storage-activity-led"
  "storage-ssd-label"
  "storage-socket-label"
  "storage-activity-label"
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

theme_svg_assets() {
  local root="$1"
  local surface="${2:-202326}"
  local border="${3:-3a3d3f}"
  local foreground="${4:-c9c3b6}"
  local accent="${5:-d08a2c}"

  SVG_SURFACE="$surface" SVG_BORDER="$border" perl -0pi -e '
    s/fill:#b4b4b4/fill:#$ENV{"SVG_SURFACE"}/g;
    s/stroke:#000000/stroke:#$ENV{"SVG_BORDER"}/g;
  ' "$root/base.svg"

  SVG_ACCENT="$accent" perl -0pi -e 's/stroke:#000000/stroke:#$ENV{"SVG_ACCENT"}/g' \
    "$root/storage/ssd.svg" \
    "$root/storage/exploded-ssd.svg" \
    "$root/storage/activity-led.svg" \
    "$root/storage/exploded-activity-led.svg" \
    "$root/storage/ssd-label.svg" \
    "$root/storage/socket-label.svg" \
    "$root/storage/activity-label.svg"

  SVG_FOREGROUND="$foreground" perl -0pi -e 's/stroke:#000000/stroke:#$ENV{"SVG_FOREGROUND"}/g' \
    "$root/storage/socket.svg" \
    "$root/storage/exploded-socket.svg"
}

require_file "$source_svg"
require_file "$exploded_svg"

for id in "${required_ids[@]}"; do
  require_id "$source_svg" "$id"
done

for id in "${exploded_required_ids[@]}"; do
  require_id "$exploded_svg" "$id"
done

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
export_id "$exploded_svg" "storage-ssd" "$storage_dir/exploded-ssd.svg"
export_id "$exploded_svg" "storage-socket" "$storage_dir/exploded-socket.svg"
export_id "$exploded_svg" "storage-activity-led" "$storage_dir/exploded-activity-led.svg"
export_id "$exploded_svg" "storage-ssd-label" "$storage_dir/ssd-label.svg"
export_id "$exploded_svg" "storage-socket-label" "$storage_dir/socket-label.svg"
export_id "$exploded_svg" "storage-activity-label" "$storage_dir/activity-label.svg"
theme_svg_assets "$runtime_dir"

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
    "activityLed": "runtime/storage/activity-led.svg",
    "explodedSsd": "runtime/storage/exploded-ssd.svg",
    "explodedSocket": "runtime/storage/exploded-socket.svg",
    "explodedActivityLed": "runtime/storage/exploded-activity-led.svg",
    "ssdLabel": "runtime/storage/ssd-label.svg",
    "socketLabel": "runtime/storage/socket-label.svg",
    "activityLabel": "runtime/storage/activity-label.svg"
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
      "socket": $(json_bbox "$exploded_svg" "storage-socket"),
      "activityLed": $(json_bbox "$exploded_svg" "storage-activity-led"),
      "labels": {
        "ssd": $(json_bbox "$exploded_svg" "storage-ssd-label"),
        "socket": $(json_bbox "$exploded_svg" "storage-socket-label"),
        "activityLed": $(json_bbox "$exploded_svg" "storage-activity-label")
      },
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

for output in \
  "$runtime_dir/base.svg" \
  "$storage_dir/ssd.svg" \
  "$storage_dir/socket.svg" \
  "$storage_dir/activity-led.svg" \
  "$storage_dir/exploded-ssd.svg" \
  "$storage_dir/exploded-socket.svg" \
  "$storage_dir/exploded-activity-led.svg" \
  "$storage_dir/ssd-label.svg" \
  "$storage_dir/socket-label.svg" \
  "$storage_dir/activity-label.svg" \
  "$manifest"; do
  [[ -s "$output" ]] || fail "expected generated file is empty or missing: $output"
done

printf 'Generated storage schematic assets in %s\n' "$runtime_dir"
printf 'Generated manifest at %s\n' "$manifest"
