{ ... }:

{
  plugins.cmp.enable = true;
  plugins.cmp-nvim-lsp.enable = true;
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
  plugins.luasnip.enable = true;
  plugins.none-ls.enable = true;
}
