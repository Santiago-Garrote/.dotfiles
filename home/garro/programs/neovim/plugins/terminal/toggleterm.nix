{ ... }:

{
  plugins.toggleterm.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>mt";
      action = "<cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "n";
      key = "<leader>mf";
      action = "<cmd>ToggleTerm direction=float<CR>";
      options.desc = "Toggle floating terminal";
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Exit terminal mode";
    }
  ];
}
