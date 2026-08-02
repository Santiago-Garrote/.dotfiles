{ lib, pkgs, ... }:

let
  managedVimPlugins = {
    "lazy.nvim" = pkgs.vimPlugins.lazy-nvim;
    LazyVim = pkgs.vimPlugins.LazyVim;
    "blink.cmp" = pkgs.vimPlugins.blink-cmp;
    "bufferline.nvim" = pkgs.vimPlugins.bufferline-nvim;
    catppuccin = pkgs.vimPlugins.catppuccin-nvim;
    "flash.nvim" = pkgs.vimPlugins.flash-nvim;
    "friendly-snippets" = pkgs.vimPlugins.friendly-snippets;
    "gitsigns.nvim" = pkgs.vimPlugins.gitsigns-nvim;
    "grug-far.nvim" = pkgs.vimPlugins.grug-far-nvim;
    "lazydev.nvim" = pkgs.vimPlugins.lazydev-nvim;
    "lualine.nvim" = pkgs.vimPlugins.lualine-nvim;
    "mini.ai" = pkgs.vimPlugins.mini-nvim;
    "mini.icons" = pkgs.vimPlugins.mini-nvim;
    "mini.pairs" = pkgs.vimPlugins.mini-nvim;
    "noice.nvim" = pkgs.vimPlugins.noice-nvim;
    "nui.nvim" = pkgs.vimPlugins.nui-nvim;
    "nvim-notify" = pkgs.vimPlugins.nvim-notify;
    "nvim-ts-autotag" = pkgs.vimPlugins.nvim-ts-autotag;
    "nvim-treesitter-textobjects" = pkgs.vimPlugins.nvim-treesitter-textobjects;
    "persistence.nvim" = pkgs.vimPlugins.persistence-nvim;
    "plenary.nvim" = pkgs.vimPlugins.plenary-nvim;
    "snacks.nvim" = pkgs.vimPlugins.snacks-nvim;
    "todo-comments.nvim" = pkgs.vimPlugins.todo-comments-nvim;
    "tokyonight.nvim" = pkgs.vimPlugins.tokyonight-nvim;
    "trouble.nvim" = pkgs.vimPlugins.trouble-nvim;
    "ts-comments.nvim" = pkgs.vimPlugins.ts-comments-nvim;
    "which-key.nvim" = pkgs.vimPlugins.which-key-nvim;
    "nvim-lspconfig" = pkgs.vimPlugins.nvim-lspconfig;
    "conform.nvim" = pkgs.vimPlugins.conform-nvim;
    "nvim-lint" = pkgs.vimPlugins.nvim-lint;
    "nvim-treesitter" = pkgs.vimPlugins.nvim-treesitter.withPlugins (parsers: [
      parsers.nix
      parsers.qmljs
    ]);
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = lib.unique (builtins.attrValues managedVimPlugins);

    extraPackages = [
      pkgs.gcc
      pkgs.tree-sitter
    ];
  };

  xdg.configFile."nvim/init.lua".source = ./config/init.lua;
  xdg.configFile."nvim/lazy-lock.json".source = ./config/lazy-lock.json;
  xdg.configFile."nvim/lua".source = ./config/lua;

  xdg.dataFile = lib.mapAttrs' (
    name: plugin: lib.nameValuePair "nvim/nix-plugins/${name}" { source = plugin; }
  ) managedVimPlugins;
}
