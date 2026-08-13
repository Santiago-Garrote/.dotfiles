{ ... }:

{
  plugins.gitsigns = {
    enable = true;

    settings = {
      current_line_blame = false;

      signs = {
        add = {
          text = "│";
        };

        change = {
          text = "│";
        };

        delete = {
          text = "󰍵";
        };

        topdelete = {
          text = "‾";
        };

        changedelete = {
          text = "~";
        };
      };

      signcolumn = true;
      numhl = false;
      linehl = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "]h";
      action = {
        __raw = ''
          function()
            require("gitsigns").next_hunk()
          end
        '';
      };
      options.desc = "Next git hunk";
    }
    {
      mode = "n";
      key = "[h";
      action = {
        __raw = ''
          function()
            require("gitsigns").prev_hunk()
          end
        '';
      };
      options.desc = "Previous git hunk";
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = {
        __raw = ''
          function()
            require("gitsigns").preview_hunk()
          end
        '';
      };
      options.desc = "Preview git hunk";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = {
        __raw = ''
          function()
            require("gitsigns").toggle_current_line_blame()
          end
        '';
      };
      options.desc = "Toggle line blame";
    }
  ];
}
