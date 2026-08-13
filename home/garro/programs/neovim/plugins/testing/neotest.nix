{ ... }:

{
  plugins.neotest.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>qr";
      action = {
        __raw = ''
          function()
            require("neotest").run.run()
          end
        '';
      };
      options.desc = "Run nearest test";
    }
    {
      mode = "n";
      key = "<leader>qf";
      action = {
        __raw = ''
          function()
            require("neotest").run.run(vim.fn.expand("%"))
          end
        '';
      };
      options.desc = "Run file tests";
    }
    {
      mode = "n";
      key = "<leader>qs";
      action = {
        __raw = ''
          function()
            require("neotest").summary.toggle()
          end
        '';
      };
      options.desc = "Toggle test summary";
    }
    {
      mode = "n";
      key = "<leader>qo";
      action = {
        __raw = ''
          function()
            require("neotest").output.open({ enter = true })
          end
        '';
      };
      options.desc = "Open test output";
    }
  ];
}
