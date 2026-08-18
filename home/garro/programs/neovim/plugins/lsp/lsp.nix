{ ... }:

{
  plugins.lsp = {
    enable = true;

    capabilities = ''
      capabilities.workspace.fileOperations = {
        willRename = true,
        didRename = true,
      }
    '';

    servers = {
      nixd = {
        enable = true;
        packageFallback = true;
        settings = {
          formatting.command = [ "nixfmt" ];
          nixpkgs.expr = "import <nixpkgs> {}";
        };
      };

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

  extraConfigLua = ''
    function _G.lsp_on_rename(from, to)
      local clients = vim.lsp.get_clients()

      for _, client in ipairs(clients) do
        if client:supports_method("workspace/willRenameFiles") then
          local response = client:request_sync(
            "workspace/willRenameFiles",
            {
              files = {
                {
                  oldUri = vim.uri_from_fname(from),
                  newUri = vim.uri_from_fname(to),
                },
              },
            },
            1000
          )

          if response and response.result then
            vim.lsp.util.apply_workspace_edit(
              response.result,
              client.offset_encoding
            )
          end
        end
      end
    end
  '';
}
