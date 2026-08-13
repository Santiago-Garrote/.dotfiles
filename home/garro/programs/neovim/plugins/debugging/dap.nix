{ ... }:

{
  plugins.dap.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>dc";
      action = {
        __raw = ''
          function()
            require("dap").continue()
          end
        '';
      };
      options.desc = "Debug continue";
    }
    {
      mode = "n";
      key = "<leader>db";
      action = {
        __raw = ''
          function()
            require("dap").toggle_breakpoint()
          end
        '';
      };
      options.desc = "Toggle breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dB";
      action = {
        __raw = ''
          function()
            require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
          end
        '';
      };
      options.desc = "Set conditional breakpoint";
    }
    {
      mode = "n";
      key = "<leader>do";
      action = {
        __raw = ''
          function()
            require("dap").step_over()
          end
        '';
      };
      options.desc = "Debug step over";
    }
    {
      mode = "n";
      key = "<leader>di";
      action = {
        __raw = ''
          function()
            require("dap").step_into()
          end
        '';
      };
      options.desc = "Debug step into";
    }
    {
      mode = "n";
      key = "<leader>dO";
      action = {
        __raw = ''
          function()
            require("dap").step_out()
          end
        '';
      };
      options.desc = "Debug step out";
    }
    {
      mode = "n";
      key = "<leader>dr";
      action = {
        __raw = ''
          function()
            require("dap").repl.toggle()
          end
        '';
      };
      options.desc = "Toggle DAP REPL";
    }
  ];
}
