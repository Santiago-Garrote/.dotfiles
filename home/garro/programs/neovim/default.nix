{ pkgs, ... }:

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

  xdg.configFile."nvim/init.lua".source = ./config/init.lua;
  xdg.configFile."nvim/lazy-lock.json".source = ./config/lazy-lock.json;
  xdg.configFile."nvim/lua".source = ./config/lua;
}
