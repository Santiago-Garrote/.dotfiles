{
  pkgs,
  theme,
  umuPackage,
  claudeCodePackage,
  codebaseMemoryMcpPackage,
  ...
}:

{
  imports = [
    ./bash
    ./direnv
    ./browsers
    (import ./desktop-apps { inherit pkgs; })
    ./dev-profiles
    ./git
    (import ./hyprlock { inherit theme; })
    (import ./kitty { inherit theme; })
    (import ./lutris { inherit pkgs umuPackage; })
    ./media
    ./neovim
    ./obs-studio
    ./ssh
    (import ./wlogout { inherit pkgs theme; })
    (import ./agents { inherit claudeCodePackage codebaseMemoryMcpPackage; })
  ];
}
