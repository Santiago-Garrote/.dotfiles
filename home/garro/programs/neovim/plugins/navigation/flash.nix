{ ... }:

{
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

  keymaps = [
    {
      mode = "n";
      key = "<leader>nj";
      action = {
        __raw = ''
          function()
            require("flash").jump()
          end
        '';
      };
      options.desc = "Flash jump";
    }
    {
      mode = [
        "n"
        "o"
        "x"
      ];
      key = "<leader>nt";
      action = {
        __raw = ''
          function()
            require("flash").treesitter()
          end
        '';
      };
      options.desc = "Flash treesitter";
    }
  ];
}
