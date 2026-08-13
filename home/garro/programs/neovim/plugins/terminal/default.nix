{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      action = "<nop>";
      options.desc = "Terminal";
    }
  ];

  imports = [
    ./toggleterm.nix
  ];
}
