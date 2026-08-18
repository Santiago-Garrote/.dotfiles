{ pkgs, ... }:

{
  extraPlugins = [
    pkgs.vimPlugins.nvim-lsp-file-operations
  ];

  extraConfigLua = ''
    require("lsp-file-operations").setup()
  '';
}
