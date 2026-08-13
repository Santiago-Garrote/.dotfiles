{ ... }:

{
  plugins.lsp = {
    enable = true;

    servers = {
      jdtls = {
        enable = true;
        packageFallback = true;
        package = null;
      };

      groovyls = {
        enable = true;
        packageFallback = true;
        package = null;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ld";
      action = {
        __raw = ''
          function()
            vim.lsp.buf.definition()
          end
        '';
      };
      options.desc = "Go to definition";
    }
    {
      mode = "n";
      key = "<leader>lr";
      action = {
        __raw = ''
          function()
            vim.lsp.buf.references()
          end
        '';
      };
      options.desc = "Find references";
    }
    {
      mode = "n";
      key = "<leader>la";
      action = {
        __raw = ''
          function()
            vim.lsp.buf.code_action()
          end
        '';
      };
      options.desc = "Code action";
    }
    {
      mode = "n";
      key = "<leader>ln";
      action = {
        __raw = ''
          function()
            vim.lsp.buf.rename()
          end
        '';
      };
      options.desc = "Rename symbol";
    }
    {
      mode = "n";
      key = "<leader>lh";
      action = {
        __raw = ''
          function()
            vim.lsp.buf.hover()
          end
        '';
      };
      options.desc = "Hover documentation";
    }
  ];
}
