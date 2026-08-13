{ ... }:

{
  plugins.noice = {
    enable = true;

    settings = {
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        lsp_doc_border = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>un";
      action = "<cmd>Noice<CR>";
      options.desc = "Open Noice";
    }
    {
      mode = "n";
      key = "<leader>um";
      action = "<cmd>Noice dismiss<CR>";
      options.desc = "Dismiss messages";
    }
    {
      mode = "n";
      key = "<leader>uL";
      action = "<cmd>Noice last<CR>";
      options.desc = "Last message";
    }
    {
      mode = "n";
      key = "<leader>uH";
      action = "<cmd>Noice history<CR>";
      options.desc = "Message history";
    }
  ];
}
