{
  pkgs,
  theme,
  umuPackage,
}:

{
  imports = [
    ./bash
    ./firefox
    (import ./hyprlock { inherit theme; })
    (import ./kitty { inherit theme; })
    (import ./lutris { inherit pkgs umuPackage; })
    ./neovim
    (import ./wlogout { inherit pkgs theme; })
  ];
}
