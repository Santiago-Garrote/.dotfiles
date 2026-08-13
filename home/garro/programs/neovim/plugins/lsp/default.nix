{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>l";
      action = "<nop>";
      options.desc = "LSP";
    }
  ];

  imports = [
    ./cmp.nix
    ./cmp-nvim-lsp.nix
    ./lsp.nix
    ./luasnip.nix
    ./none-ls.nix
  ];
}
