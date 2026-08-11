{ ... }:

{
  plugins.lualine = {
  enable = true;
  
  settings = {
  options = {
  globalstatus = true;
  icons_enabled = true;
  
  component_separators = {
  left = "│";
  right = "│";
  };
  
  section_separators = {
  left = "";
  right = "";
  };
  
  disabled_filetypes = [
  "alpha"
  "dashboard"
  "neo-tree"
  "lazy"
  "mason"
  "NvimTree"
  "TelescopePrompt"
  ];
  };
  
  sections = {
  lualine_a = [ "mode" ];
  
  lualine_b = [
  "branch"
  "diff"
  "diagnostics"
  ];
  
  lualine_c = [
  {
  __unkeyed-1 = "filename";
  path = 1;
  symbols = {
  modified = " ●";
  readonly = " ";
  unnamed = "[No Name]";
  };
  }
  ];
  
  lualine_x = [
  "filetype"
  "encoding"
  ];
  
  lualine_y = [
  "progress"
  ];
  
  lualine_z = [
  "location"
  ];
  };
  };
  };

}
