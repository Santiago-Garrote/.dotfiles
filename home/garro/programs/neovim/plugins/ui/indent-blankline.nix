{ ... }:

{
  plugins.indent-blankline = {
  enable = true;
  
  settings = {
  indent = {
  char = "│";
  };
  
  scope = {
  enabled = true;
  show_start = false;
  show_end = false;
  };
  
  exclude = {
  filetypes = [
  "help"
  "dashboard"
  "neo-tree"
  "Trouble"
  "lazy"
  "mason"
  ];
  };
  };
  };

}
