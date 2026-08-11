{ ... }:

{
  plugins.web-devicons.enable = true;

  plugins.lualine = {
    enable = true;

    settings = {
      options = {
        globalstatus = true;
        icons_enabled = true;

        component_separators = {
          left = "│";
          right = "│";
        };

        section_separators = {
          left = "";
          right = "";
        };

        disabled_filetypes = [
          "alpha"
          "dashboard"
          "neo-tree"
          "lazy"
          "mason"
          "NvimTree"
          "TelescopePrompt"
        ];
      };

      sections = {
        lualine_a = [ "mode" ];

        lualine_b = [
          "branch"
          "diff"
          "diagnostics"
        ];

        lualine_c = [
          {
            __unkeyed-1 = "filename";
            path = 1;
            symbols = {
              modified = " ●";
              readonly = " ";
              unnamed = "[No Name]";
            };
          }
        ];

        lualine_x = [
          "filetype"
          "encoding"
        ];

        lualine_y = [
          "progress"
        ];

        lualine_z = [
          "location"
        ];
      };
    };
  };

  plugins.bufferline = {
    enable = true;

    settings = {
      options = {
        mode = "buffers";

        diagnostics = "nvim_lsp";

        always_show_bufferline = true;

        show_buffer_close_icons = true;
        show_close_icon = true;
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

  plugins.which-key = {
    enable = true;

    settings = {
      preset = "modern";
      delay = 300;

      icons = {
        mappings = true;
      };
    };
  };

  plugins.indent-blankline = {
    enable = true;

    settings = {
      indent = {
        char = "│";
      };

      scope = {
        enabled = true;
        show_start = false;
        show_end = false;
      };

      exclude = {
        filetypes = [
          "help"
          "dashboard"
          "neo-tree"
          "Trouble"
          "lazy"
          "mason"
        ];
      };
    };
  };

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
}
