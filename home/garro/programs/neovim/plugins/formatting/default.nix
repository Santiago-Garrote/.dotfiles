{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      action = "<nop>";
      options.desc = "Format";
    }
  ];

  imports = [
    ./conform-nvim.nix
  ];
}
