{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>d";
      action = "<nop>";
      options.desc = "Debug";
    }
  ];

  imports = [
    ./dap.nix
    ./dap-ui.nix
    ./dap-virtual-text.nix
  ];
}
