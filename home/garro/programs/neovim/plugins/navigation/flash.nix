{ ... }:

{
  plugins.flash = {
  enable = true;
  
  settings = {
  labels = "asdfghjklqwertyuiopzxcvbnm";
  
  modes = {
  char = {
  enabled = true;
  jump_labels = true;
  };
  
  search = {
  enabled = true;
  };
  
  treesitter = {
  labels = "asdfghjklqwertyuiopzxcvbnm";
  };
  };
  };
  };

}
