{ ... }:

{
  plugins.project-nvim = {
    enable = true;
    enableTelescope = true;

    settings = {
      detection_methods = [
        "lsp"
        "pattern"
      ];

      patterns = [
        ".git"
        "flake.nix"
        "build.gradle"
        "build.gradle.kts"
        "settings.gradle"
        "settings.gradle.kts"
        "pom.xml"
        "package.json"
        "Cargo.toml"
        "Makefile"
        "CMakeLists.txt"
      ];

      show_hidden = true;

      silent_chdir = true;

      scope_chdir = "global";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>pp";
      action = "<cmd>Telescope projects<CR>";
      options.desc = "Find projects";
    }
  ];
}
