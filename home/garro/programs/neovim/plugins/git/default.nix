{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>g";
      action = "<nop>";
      options.desc = "Git";
    }
  ];

  imports = [
    ./diffview.nix
    ./gitsigns.nix
    ./lazygit.nix
  ];
}
