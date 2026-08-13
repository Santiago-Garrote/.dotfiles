{ ... }:

{
  plugins.which-key = {
    enable = true;

    settings = {
      preset = "modern";
      delay = 300;

      icons = {
        mappings = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>uk";
      action = "<cmd>WhichKey<CR>";
      options.desc = "Show keymaps";
    }
  ];
}
