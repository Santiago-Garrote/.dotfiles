{ pkgs, theme }:

let
  themeFile = import ./theme.nix { inherit pkgs theme; };

  configTree = pkgs.runCommand "quickshell-config" { } ''
    mkdir -p "$out"
    cp -r ${../../widgets/quickshell}/. "$out/"
    chmod -R u+w "$out"
    cp ${themeFile} "$out/Theme.qml"
  '';
in
{
  xdg.configFile."quickshell".source = configTree;
}
