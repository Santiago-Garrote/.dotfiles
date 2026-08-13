{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>x";
      action = "<nop>";
      options.desc = "Diagnostics";
    }
  ];

  imports = [
    ./lint.nix
    ./todo-comments.nix
    ./trouble.nix
  ];
}
