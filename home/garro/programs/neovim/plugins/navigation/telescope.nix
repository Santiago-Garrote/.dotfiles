{ ... }:

{
  plugins.telescope = {
    enable = true;

    settings = {
      defaults = {
        layout_strategy = "horizontal";

        layout_config = {
          horizontal = {
            preview_width = 0.55;
          };

          width = 0.90;
          height = 0.85;
        };

        sorting_strategy = "ascending";

        prompt_prefix = "󰍉  ";
        selection_caret = " ";

        file_ignore_patterns = [
          "^.git/"
          "node_modules"
          "target"
          "build"
          "dist"
          ".gradle"
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>nf";
      action = "<cmd>Telescope find_files<CR>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>ng";
      action = "<cmd>Telescope live_grep<CR>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>nb";
      action = "<cmd>Telescope buffers<CR>";
      options.desc = "Find buffers";
    }
    {
      mode = "n";
      key = "<leader>nh";
      action = "<cmd>Telescope help_tags<CR>";
      options.desc = "Find help tags";
    }
  ];
}
