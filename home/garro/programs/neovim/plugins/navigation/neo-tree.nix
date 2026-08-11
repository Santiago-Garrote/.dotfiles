{ ... }:

{
  plugins.neo-tree = {
  enable = true;
  
  settings = {
  close_if_last_window = true;
  
  enable_git_status = true;
  enable_diagnostics = true;
  
  filesystem = {
  follow_current_file = {
  enabled = true;
  leave_dirs_open = true;
  };
  
  filtered_items = {
  hide_dotfiles = false;
  hide_gitignored = true;
  hide_hidden = false;
  };
  };
  
  window = {
  width = 32;
  mappings = {
  "<space>" = "none";
  };
  };
  };
  };

}
