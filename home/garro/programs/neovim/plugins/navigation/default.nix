{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>n";
      action = "<nop>";
      options.desc = "Navigation";
    }
  ];

  imports = [
    ./flash.nix
    ./harpoon.nix
    ./neo-tree.nix
    ./oil.nix
    ./telescope.nix
  ];
}
