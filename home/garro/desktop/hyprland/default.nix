{
  pkgs,
  theme,
  ...
}:

let
  monitors = import ./monitors.nix;
  environment = import ./environment.nix { inherit pkgs; };
  hyprTheme = import ./theme.nix { inherit theme; };
  keybindings = import ./keybindings.nix;
  animations = import ./animations.nix;
in
{
  imports = [
    (import ./packages.nix { inherit pkgs; })
  ];

  xdg.configFile."hypr/hyprland.lua".text = ''
    -- Personal Hyprland Configuration.
    -- Managed declaratively by Home Manager-

    ${monitors}
    ${environment}
    ${hyprTheme}
    ${keybindings}
    ${animations}
  '';
}
