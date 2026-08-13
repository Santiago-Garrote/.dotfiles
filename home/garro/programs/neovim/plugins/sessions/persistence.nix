{ ... }:

{
  plugins.persistence = {
    enable = true;

    settings = {
      dir = {
        __raw = ''vim.fn.stdpath("state") .. "/sessions/"'';
      };

      options = [
        "buffers"
        "curdir"
        "tabpages"
        "winsize"
        "folds"
        "globals"
      ];

      pre_save = {
        __raw = ''
          function()
          vim.cmd("Neotree close")
          end
        '';
      };

      need = 1;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>sl";
      action = "<cmd>PersistenceLoad<CR>";
      options.desc = "Load session";
    }
    {
      mode = "n";
      key = "<leader>ss";
      action = "<cmd>PersistenceSave<CR>";
      options.desc = "Save session";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action = "<cmd>PersistenceStop<CR>";
      options.desc = "Stop session persistence";
    }
  ];
}
