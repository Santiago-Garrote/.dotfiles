{ ... }:

{
  plugins.bufferline = {
  enable = true;
  
  settings = {
  options = {
  mode = "buffers";
  
  diagnostics = "nvim_lsp";
  
  always_show_bufferline = true;
  
  show_buffer_close_icons = true;
  show_close_icon = true;
  show_buffer_icons = true;
  
  modified_icon = "●";
  close_icon = "󰅖";
  
  separator_style = "thin";
  
  persist_buffer_sort = true;
  
  offsets = [
  {
  filetype = "neo-tree";
  text = "File Explorer";
  text_align = "center";
  separator = true;
  }
  ];
  };
  };
  };

}
