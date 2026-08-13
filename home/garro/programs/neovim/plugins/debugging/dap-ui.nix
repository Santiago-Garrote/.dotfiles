{ ... }:

{
  plugins.dap-ui.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>du";
      action = {
        __raw = ''
          function()
            require("dapui").toggle()
          end
        '';
      };
      options.desc = "Toggle DAP UI";
    }
  ];
}
