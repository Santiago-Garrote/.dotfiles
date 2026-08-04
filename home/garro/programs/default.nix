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
    ./obs-studio
    ./ssh
    (import ./wlogout { inherit pkgs theme; })
  ];
}
