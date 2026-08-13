{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>s";
      action = "<nop>";
      options.desc = "Sessions";
    }
  ];

  imports = [
    ./persistence.nix
  ];
}
