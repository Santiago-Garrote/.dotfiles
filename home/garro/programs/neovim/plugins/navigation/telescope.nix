{ ... }:

{
  plugins.telescope = {
  enable = true;
  
  settings = {
  defaults = {
  layout_strategy = "horizontal";
  
  layout_config = {
  horizontal = {
  preview_width = 0.55;
  };
  
  width = 0.90;
  height = 0.85;
  };
  
  sorting_strategy = "ascending";
  
  prompt_prefix = "󰍉  ";
  selection_caret = " ";
  
  file_ignore_patterns = [
  "^.git/"
  "node_modules"
  "target"
  "build"
  "dist"
  ".gradle"
  ];
  };
  };
  };

}
