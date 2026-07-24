{ pkgs }:

pkgs.mkShell {
  packages = [
    pkgs.quickshell
    pkgs.qt6.qtdeclarative
  ];
}
