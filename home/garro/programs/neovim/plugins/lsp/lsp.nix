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

}
