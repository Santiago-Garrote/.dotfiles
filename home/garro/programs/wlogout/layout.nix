{ pkgs, scripts }:

{
  programs.wlogout.layout = [
    {
      label = "lock";
      action = "${pkgs.systemd}/bin/loginctl lock-session";
      text = "LOCK";
      keybind = "l";
    }

    {
      label = "logout";
      action = "${scripts.sessionLogout}/bin/session-logout";
      text = "LOG OUT";
      keybind = "e";
    }

    {
      label = "reboot";
      action = "${scripts.sessionReboot}/bin/session-reboot";
      text = "REBOOT";
      keybind = "r";
    }

    {
      label = "poweroff";
      action = "${scripts.sessionPowerOff}/bin/session-power-off";
      text = "POWER OFF";
      keybind = "p";
    }
  ];
}
