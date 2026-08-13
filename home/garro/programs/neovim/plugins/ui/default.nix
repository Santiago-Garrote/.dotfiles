{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>u";
      action = "<nop>";
      options.desc = "UI";
    }
  ];

  imports = [
    ./bufferline.nix
    ./indent-blankline.nix
    ./lualine.nix
    ./noice.nix
    ./web-devicons.nix
    ./which-key.nix
  ];
}
