{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>q";
      action = "<nop>";
      options.desc = "Testing";
    }
  ];

  imports = [
    ./neotest.nix
  ];
}
