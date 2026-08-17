{ ... }:

{
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

        hijack_netrw_behavior = "open_default";
      };

      window = {
        width = 32;
        mappings = {
          "<space>" = "none";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ne";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle file explorer";
    }
    {
      mode = "n";
      key = "<leader>nr";
      action = "<cmd>Neotree reveal<CR>";
      options.desc = "Reveal current file";
    }
  ];
}
