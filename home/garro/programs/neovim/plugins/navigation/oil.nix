{ ... }:

{
  plugins.oil = {
  enable = true;
  
  settings = {
  columns = [
  "icon"
  "permissions"
  "size"
  "mtime"
  ];
  
  delete_to_trash = true;
  
  skip_confirm_for_simple_edits = true;
  
  view_options = {
  show_hidden = true;
  };
  
  float = {
  padding = 2;
  max_width = 120;
  max_height = 30;
  };
  };
  };

}
