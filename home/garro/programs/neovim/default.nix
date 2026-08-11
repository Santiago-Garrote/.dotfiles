{ lib, pkgs, ... }:

let
  pluginsDir = ./plugins;
  pluginFiles = lib.pipe (builtins.readDir pluginsDir) [
    builtins.attrNames
    (builtins.filter (name: lib.hasSuffix ".nix" name))
    (builtins.map (name: pluginsDir + "/${name}"))
  ];
in
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    nixpkgs.source = pkgs.path;

    imports = pluginFiles;
  };
}
