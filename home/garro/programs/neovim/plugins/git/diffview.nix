{ ... }:

{
  plugins.diffview = {
    enable = true;

    settings = {
      enhanced_diff_hl = true;

      view = {
        default = {
          layout = "diff2_horizontal";
          winbar_info = true;
        };

        merge_tool = {
          layout = "diff3_horizontal";
          disable_diagnostics = true;
        };
      };

      file_panel = {
        listing_style = "tree";
        win_config = {
          position = "left";
          width = 35;
        };
      };

      hooks = {
        diff_buf_read = {
          __raw = ''
            function(bufnr)
            vim.opt_local.wrap = false
            vim.opt_local.list = false
            end
          '';
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gd";
      action = "<cmd>DiffviewOpen<CR>";
      options.desc = "Open diff view";
    }
    {
      mode = "n";
      key = "<leader>gD";
      action = "<cmd>DiffviewClose<CR>";
      options.desc = "Close diff view";
    }
    {
      mode = "n";
      key = "<leader>gh";
      action = "<cmd>DiffviewFileHistory<CR>";
      options.desc = "File history";
    }
  ];
}
