{
  pkgs,
  theme,
  umuPackage,
  claudeCodePackage,
  ...
}:

{
  imports = [
    ./bash
    ./direnv
    ./browsers
    ./git
    (import ./hyprlock { inherit theme; })
    (import ./kitty { inherit theme; })
    (import ./lutris { inherit pkgs umuPackage; })
    ./media
    ./neovim
    ./obs-studio
    ./ssh
    (import ./wlogout { inherit pkgs theme; })
    (import ./agents { inherit claudeCodePackage; })
  ];
}
