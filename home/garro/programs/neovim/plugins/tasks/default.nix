{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>t";
      action = "<nop>";
      options.desc = "Tasks";
    }
  ];

  imports = [
    ./overseer.nix
  ];
}
