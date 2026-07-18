{ pkgs, theme, ... }:

let
  sessionLogout = pkgs.writeShellApplication {
    name = "session-logout";

    runtimeInputs = [
      pkgs.hyprshutdown
    ];

    text = ''
      exec hyprshutdown \
        --top-label "LOG OUT // CLOSE SESSION"
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
in
{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "${pkgs.systemd}/bin/loginctl lock-session";
        text = "LOCK";
        keybind = "l";
      }

      {
        label = "logout";
        action = "${sessionLogout}/bin/session-logout";
        text = "LOG OUT";
        keybind = "e";
      }

      {
        label = "reboot";
        action = "${sessionReboot}/bin/session-reboot";
        text = "REBOOT";
        keybind = "r";
      }

      {
        label = "poweroff";
        action = "${sessionPowerOff}/bin/session-power-off";
        text = "POWER OFF";
        keybind = "p";
      }
    ];

    style = ''
      * {
        font-family: "${theme.typography.monospace}";
        font-size: 14px;
      }

      window {
        background-color: #${theme.colors.background};
      }

      button {
        color: #${theme.colors.text};

        background-color: #${theme.colors.surface};
        background-image: none;

        border: ${toString theme.geometry.borderWidth}px solid #${theme.colors.border};
        border-radius: ${toString theme.geometry.radius}px;

        margin: ${toString theme.geometry.gapIner}px;
        padding: 24px;

        box-shadow: none;
        text-shadow: none;
      }

      button:hover,
      button:focus {
        color: #${theme.colors.onPrimary};

        background-color: #${theme.colors.primary};
        background-image: none;

        border-color: #${theme.colors.primary};
      }

      #logout {
        border-color: #${theme.colors.primary};
      }

      #reboot,
      #poweroff {
        border-color: #${theme.colors.error};
      }

      #reboot:hover,
      #reboot:focus,
      #poweroff:hover,
      #poweroff:focus {
        color: #${theme.colors.onError};
        background-color: #${theme.colors.error};
        border-color: #${theme.colors.error};
      }
    '';
  };

  home.packages = [
    powerMenu

    # Useful for manually testing its confirmation screen.
    pkgs.hyprshutdown
  ];
}
