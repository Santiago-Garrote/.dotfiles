{ ... }:

{
  plugins.comment = {
    enable = true;

    settings = {
      mappings = {
        basic = true;
        extra = true;
      };
    };
  };

  plugins.mini-ai = {
    enable = true;

    settings = {
      n_lines = 500;
      search_method = "cover_or_nearest";
    };
  };

  plugins.mini-surround = {
    enable = true;

    settings = {
      mappings = {
        add = "gsa";
        delete = "gsd";
        find = "gsf";
        find_left = "gsF";
        highlight = "gsh";
        replace = "gsr";
        update_n_lines = "gsn";
      };
    };
  };

  plugins.nvim-autopairs = {
    enable = true;

    settings = {
      check_ts = true;
      disable_filetype = [
        "TelescopePrompt"
        "vim"
      ];
    };
  };

  plugins.ts-autotag = {
    enable = true;
  };
}

