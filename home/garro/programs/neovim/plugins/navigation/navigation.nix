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
    };
  };

  plugins.neo-tree = {
    enable = true;

    settings = {
      close_if_last_window = true;

      enable_git_status = true;
      enable_diagnostics = true;

      filesystem = {
        follow_current_file = {
          enabled = true;
          leave_dirs_open = true;
        };

        filtered_items = {
          hide_dotfiles = false;
          hide_gitignored = true;
          hide_hidden = false;
        };
      };

      window = {
        width = 32;
        mappings = {
          "<space>" = "none";
        };
      };
    };
  };

  plugins.flash = {
    enable = true;

    settings = {
      labels = "asdfghjklqwertyuiopzxcvbnm";

      modes = {
        char = {
          enabled = true;
          jump_labels = true;
        };

        search = {
          enabled = true;
        };

        treesitter = {
          labels = "asdfghjklqwertyuiopzxcvbnm";
        };
      };
    };
  };

  plugins.harpoon = {
    enable = true;
  };
}
