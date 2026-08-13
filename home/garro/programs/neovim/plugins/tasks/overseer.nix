{ ... }:

{
  plugins.overseer.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>OverseerToggle<CR>";
      options.desc = "Toggle tasks";
    }
    {
      mode = "n";
      key = "<leader>tr";
      action = "<cmd>OverseerRun<CR>";
      options.desc = "Run task";
    }
    {
      mode = "n";
      key = "<leader>ta";
      action = "<cmd>OverseerTaskAction<CR>";
      options.desc = "Task action";
    }
  ];
}
