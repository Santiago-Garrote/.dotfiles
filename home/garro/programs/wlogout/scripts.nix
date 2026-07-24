{ pkgs }:

{
  sessionLogout = pkgs.writeShellApplication {
    name = "session-logout";

    runtimeInputs = [
      pkgs.uwsm
    ];

    text = ''
      exec uwsm stop
    '';
  };

  sessionReboot = pkgs.writeShellApplication {
    name = "session-reboot";

    runtimeInputs = [
      pkgs.hyprshutdown
      pkgs.systemd
    ];

    text = ''
      exec hyprshutdown \
        --top-label "REBOOT // CLOSE SESSION" \
        --post-cmd "systemctl reboot"
    '';
  };

  sessionPowerOff = pkgs.writeShellApplication {
    name = "session-power-off";

    runtimeInputs = [
      pkgs.hyprshutdown
      pkgs.systemd
    ];

    text = ''
      exec hyprshutdown \
        --top-label "POWER OFF // CLOSE SESSION" \
        --post-cmd "systemctl poweroff"
    '';
  };

  powerMenu = pkgs.writeShellApplication {
    name = "power-menu";

    runtimeInputs = [
      pkgs.wlogout
    ];

    text = ''
      exec wlogout \
        --buttons-per-row 2 \
        --column-spacing 12 \
        --row-spacing 12 \
        --margin 240 \
        --show-binds \
        --no-span
    '';
  };
}
