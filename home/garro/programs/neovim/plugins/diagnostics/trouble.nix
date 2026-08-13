{ ... }:

{
  plugins.trouble = {
    enable = true;

    settings = {
      auto_close = true;
      auto_preview = true;
      focus = true;
      follow = true;

      indent = {
        fold_lines = true;
        padding = 2;
      };

      multiline = true;

      position = "bottom";

      win = {
        size = 10;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<CR>";
      options.desc = "Toggle diagnostics list";
    }
    {
      mode = "n";
      key = "<leader>xX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
      options.desc = "Toggle buffer diagnostics";
    }
    {
      mode = "n";
      key = "<leader>xs";
      action = "<cmd>Trouble symbols toggle focus=false<CR>";
      options.desc = "Toggle symbols list";
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>Trouble qflist toggle<CR>";
      options.desc = "Toggle quickfix list";
    }
  ];
}
