{ config, pkgs, ... }:

let
  neovimConfigPath = "${config.home.homeDirectory}/.dotfiles/home/garro/programs/neovim/config";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = [
      pkgs.vimPlugins.lazy-nvim
      pkgs.vimPlugins.LazyVim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.conform-nvim
      pkgs.vimPlugins.nvim-lint
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (parsers: [
        parsers.nix
        parsers.qmljs
      ]))
    ];
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink neovimConfigPath;
}
