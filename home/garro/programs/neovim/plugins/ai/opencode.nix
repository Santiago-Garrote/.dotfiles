{ ... }:

{
  plugins.opencode.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>ao";
      action = "<cmd>Opencode<CR>";
      options.desc = "Open Opencode";
    }
  ];
}
