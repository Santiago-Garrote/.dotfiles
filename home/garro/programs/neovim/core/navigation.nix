{ ... }:

{
  opts = {
    scrolloff = 8;
    sidescrolloff = 8;

    splitbelow = true;
    splitright = true;
  };
  keymaps = [

    # Window navigation
    {
      key = "<C-h>";
      action = "<C-w>h";
      mode = "n";
      options.desc = "Move to left window";
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
      mode = "n";
      options.desc = "Move to lower window";
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
      mode = "n";
      options.desc = "Move to upper window";
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
      mode = "n";
      options.desc = "Move to right window";
    }

    # Buffer navigation
    {
      key = "<S-h>";
      action = "<cmd>bprevious<CR>";
      mode = "n";
      options.desc = "Previous buffer";
    }
    {
      key = "<S-l>";
      action = "<cmd>bnext<CR>";
      mode = "n";
      options.desc = "Next buffer";
    }
    {
      key = "<leader>bd";
      action = "<cmd>bdelete<CR>";
      mode = "n";
      options.desc = "Delete buffer";
    }

    # Tab navigation
    {
      key = "<leader><Tab>n";
      action = "<cmd>tabnext<CR>";
      mode = "n";
      options.desc = "Next tab";
    }
    {
      key = "<leader><Tab>p";
      action = "<cmd>tabprevious<CR>";
      mode = "n";
      options.desc = "Previous tab";
    }

    # Window resizing
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<CR>";
      options.desc = "Increase window height";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<CR>";
      options.desc = "Decrease window height";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<CR>";
      options.desc = "Decrease window width";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<CR>";
      options.desc = "Increase window width";
    }
  ];
}
