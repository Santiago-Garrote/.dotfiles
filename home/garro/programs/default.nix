{
  pkgs,
  theme,
  umuPackage,
}:

{
  imports = [
    ./bash
    ./direnv
    ./firefox
    ./git
    (import ./hyprlock { inherit theme; })
    (import ./kitty { inherit theme; })
    (import ./lutris { inherit pkgs umuPackage; })
    ./neovim
    ./ssh
    (import ./wlogout { inherit pkgs theme; })
  ];
}
