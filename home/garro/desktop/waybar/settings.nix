{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 26;

      "modules-left" = [
        "hyprland/workspaces"
      ];

      "modules-center" = [
        "clock"
      ];

      "modules-right" = [
        "network"
        "battery"
      ];

      clock = {
        format = "{:%H:%M}";
      };

      network = {
        "format-wifi" = "{essid} {signalStrength}%";
        "format-ethernet" = "Ethernet";
        "format-disconnected" = "Offline";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };

        format = "{capacity}%";
        "format-charging" = "CHG {capacity}%";
        "format-plugged" = "AC {capacity}%";
      };
    };
  };
}
