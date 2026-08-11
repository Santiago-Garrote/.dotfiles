{ ... }:

{
  plugins.conform-nvim = {
  enable = true;
  
  settings = {
  format_on_save = {
  timeout_ms = 500;
  lsp_fallback = true;
  };
  
  formatters_by_ft = {
  nix = [ "nixfmt" ];
  
  lua = [ "stylua" ];
  
  javascript = [ "prettier" ];
  javascriptreact = [ "prettier" ];
  
  typescript = [ "prettier" ];
  typescriptreact = [ "prettier" ];
  
  json = [ "prettier" ];
  jsonc = [ "prettier" ];
  
  markdown = [ "prettier" ];
  
  yaml = [ "prettier" ];
  
  html = [ "prettier" ];
  
  css = [ "prettier" ];
  };
  };
  };

}
