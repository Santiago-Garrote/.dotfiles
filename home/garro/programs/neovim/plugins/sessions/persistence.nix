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

}
