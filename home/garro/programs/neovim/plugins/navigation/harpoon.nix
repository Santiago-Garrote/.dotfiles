{ ... }:

{
  plugins.harpoon = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>na";
      action = {
        __raw = ''
          function()
            require("harpoon"):list():add()
          end
        '';
      };
      options.desc = "Add file to Harpoon";
    }
    {
      mode = "n";
      key = "<leader>nm";
      action = {
        __raw = ''
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end
        '';
      };
      options.desc = "Harpoon menu";
    }
    {
      mode = "n";
      key = "<leader>n1";
      action = {
        __raw = ''
          function()
            require("harpoon"):list():select(1)
          end
        '';
      };
      options.desc = "Harpoon file 1";
    }
    {
      mode = "n";
      key = "<leader>n2";
      action = {
        __raw = ''
          function()
            require("harpoon"):list():select(2)
          end
        '';
      };
      options.desc = "Harpoon file 2";
    }
  ];
}
