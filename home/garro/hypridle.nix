{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;

    # Generate the configuration without relying on a
    # Wayland systemd session target.
    package = null;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";

        # Ensure the session locks before suspend events,
        # even though automatic suspend is not enabled yet.
        before_sleep_cmd = "loginctl lock-session";

        # Avoid needing a second input after waking up.
        after_sleep_cmd =
          "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";

        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        ignore_wayland_inhibit = false;

        inhibit_sleep = 3;
      };

      listener = [
        {
          timeout = 300;
          "on-timeout" = "loginctl lock-session";
        }
      ];
    };
  };

  # Make the daemon available to Hyprland autostart
  # and for manual debugging.
  home.packages = [
    pkgs.hypridle
  ];
}
