{ ... }:

{
  plugins.bufferline = {
    enable = true;

    settings = {
      options = {
        mode = "buffers";

        diagnostics = "nvim_lsp";

        always_show_bufferline = true;

        show_buffer_icons = true;

        modified_icon = "●";
        close_icon = "󰅖";

        separator_style = "thin";

        persist_buffer_sort = true;

        offsets = [
          {
            filetype = "neo-tree";
            text = "File Explorer";
            text_align = "center";
            separator = true;
          }
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>uh";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.desc = "Previous buffer";
    }
    {
      mode = "n";
      key = "<leader>ul";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "<leader>up";
      action = "<cmd>BufferLinePick<CR>";
      options.desc = "Pick buffer";
    }
    {
      mode = "n";
      key = "<leader>uc";
      action = "<cmd>BufferLinePickClose<CR>";
      options.desc = "Pick buffer to close";
    }
  ];
}
