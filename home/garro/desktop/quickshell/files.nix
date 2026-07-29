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
    cp ${themeFile} "$out/Theme.qml"
  '';
in
{
  xdg.configFile."quickshell".source = configTree;
}
