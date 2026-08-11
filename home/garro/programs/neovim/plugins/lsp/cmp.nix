{ ... }:

{
  plugins.cmp = {
    enable = true;

    autoEnableSources = true;

    settings = {
      completion = {
        completeopt = "menu,menuone,noselect";
      };

      snippet = {
        expand = "function(args) require('luasnip').lsp_expand(args.body) end";
      };

      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";

        "<CR>" = "cmp.mapping.confirm({ select = false })";

        "<Tab>" = "cmp.mapping.select_next_item()";
        "<S-Tab>" = "cmp.mapping.select_prev_item()";

        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
      };

      sources = [
        {
          name = "nvim_lsp";
        }
        {
          name = "luasnip";
        }
        {
          name = "path";
        }
        {
          name = "buffer";
        }
      ];

      window = {
        completion = {
          border = "rounded";
        };

        documentation = {
          border = "rounded";
        };
      };
    };
  };

}
