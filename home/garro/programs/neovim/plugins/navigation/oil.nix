{ ... }:

{
  plugins.oil = {
    enable = true;

    settings = {
      columns = [
        "icon"
        "permissions"
        "size"
        "mtime"
      ];

      delete_to_trash = true;

      skip_confirm_for_simple_edits = true;

      view_options = {
        show_hidden = true;
      };

      float = {
        padding = 2;
        max_width = 120;
        max_height = 30;
      };

      default_file_explorer = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>no";
      action = "<cmd>Oil<CR>";
      options.desc = "Open parent directory";
    }
    {
      mode = "n";
      key = "<leader>nO";
      action = "<cmd>Oil --float<CR>";
      options.desc = "Open parent directory float";
    }
  ];
}
