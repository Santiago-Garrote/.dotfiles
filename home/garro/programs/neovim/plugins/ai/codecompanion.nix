{ ... }:

{
  plugins.codecompanion.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>ac";
      action = "<cmd>CodeCompanionChat Toggle<CR>";
      options.desc = "Toggle CodeCompanion chat";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>aA";
      action = "<cmd>CodeCompanionActions<CR>";
      options.desc = "CodeCompanion actions";
    }
  ];
}
