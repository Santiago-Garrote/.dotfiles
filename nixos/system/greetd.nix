{ pkgs, ... }:

{
  # Owns tty1's session/seat setup and launches Hyprland directly (no visible
  # greeter). Replaces getty autologin + `exec uwsm` from the bash profile,
  # which raced logind's seat creation and left Hyprland grabbing the DRM
  # device before it was ready.
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.uwsm}/bin/uwsm start hyprland.desktop";
        user = "garro";
      };
      default_session = {
        command = "${pkgs.uwsm}/bin/uwsm start hyprland.desktop";
        user = "garro";
      };
    };
  };
}
