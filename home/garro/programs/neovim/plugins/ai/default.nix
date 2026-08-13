{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>a";
      action = "<nop>";
      options.desc = "AI";
    }
  ];

  imports = [
    ./avante.nix
    ./codecompanion.nix
    ./opencode.nix
  ];
}
