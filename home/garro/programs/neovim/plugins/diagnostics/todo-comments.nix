{ ... }:

{
  plugins.todo-comments.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>xt";
      action = "<cmd>TodoTrouble<CR>";
      options.desc = "Todo diagnostics";
    }
    {
      mode = "n";
      key = "<leader>xT";
      action = "<cmd>TodoTelescope<CR>";
      options.desc = "Find todo comments";
    }
  ];
}
