{ pkgs, theme }:

let
  themeFile = import ./theme.nix { inherit pkgs theme; };

  configTree = pkgs.runCommand "quickshell-config" { } ''
    mkdir -p "$out"
    cp -r ${../../widgets/quickshell}/. "$out/"
    chmod -R u+w "$out"
    mkdir -p "$out/assets/system-schematic"
    cp -r ${../../../../assets/system_widget/runtime} "$out/assets/system-schematic/runtime"
    cp ${../../../../assets/system_widget/manifest.json} "$out/assets/system-schematic/manifest.json"
    schematicAssets="$out/assets/system-schematic/runtime"
    ${pkgs.perl}/bin/perl -0pi -e '
      s/fill:#(?:b4b4b4|202326)/fill:#${theme.colors.surface}/g;
      s/stroke:#(?:000000|3a3d3f)/stroke:#${theme.colors.border}/g;
    ' "$schematicAssets/base.svg"
    ${pkgs.perl}/bin/perl -0pi -e 's/stroke:#(?:000000|d08a2c)/stroke:#${theme.colors.accent}/g' \
      "$schematicAssets/storage/ssd.svg" \
      "$schematicAssets/storage/exploded-ssd.svg" \
      "$schematicAssets/storage/activity-led.svg" \
      "$schematicAssets/storage/exploded-activity-led.svg" \
      "$schematicAssets/storage/ssd-label.svg" \
      "$schematicAssets/storage/socket-label.svg" \
      "$schematicAssets/storage/activity-label.svg"
    ${pkgs.perl}/bin/perl -0pi -e 's/stroke:#(?:000000|c9c3b6)/stroke:#${theme.colors.foreground}/g' \
      "$schematicAssets/storage/socket.svg" \
      "$schematicAssets/storage/exploded-socket.svg"
    cp ${themeFile} "$out/Theme.qml"
  '';
in
{
  xdg.configFile."quickshell".source = configTree;
}
