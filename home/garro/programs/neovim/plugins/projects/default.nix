{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>p";
      action = "<nop>";
      options.desc = "Projects";
    }
  ];

  imports = [
    ./project-nvim.nix
  ];
}
