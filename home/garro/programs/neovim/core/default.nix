{ ... }:

{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  imports = [
    ./autocmds.nix
    ./editing.nix
    ./folds.nix
    ./navigation.nix
    ./search.nix
    ./ui.nix
  ];
}
