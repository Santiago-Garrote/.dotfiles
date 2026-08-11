{ ... }:

{
  plugins.diffview = {
  enable = true;
  
  settings = {
  enhanced_diff_hl = true;
  
  view = {
  default = {
  layout = "diff2_horizontal";
  winbar_info = true;
  };
  
  merge_tool = {
  layout = "diff3_horizontal";
  disable_diagnostics = true;
  };
  };
  
  file_panel = {
  listing_style = "tree";
  win_config = {
  position = "left";
  width = 35;
  };
  };
  
  hooks = {
  diff_buf_read = {
  __raw = ''
  function(bufnr)
  vim.opt_local.wrap = false
  vim.opt_local.list = false
  end
  '';
  };
  };
  };
  };

}
