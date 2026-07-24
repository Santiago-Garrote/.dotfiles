{ theme, ... }:

let
  colors = theme.colors;
  geometry = theme.geometry;
  typography = theme.typography;
in
{
  programs.waybar = {
    enable = true;

    # Home Manager starts Waybar through the user systemd unit.
    systemd.enable = true;

    settings = {
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

    style = ''
       /* Semantic theme adapter */

       @define-color background #${colors.background};
       @define-color surface #${colors.surface};
       @define-color border_color #${colors.border};

       @define-color text_color #${colors.text};
       @define-color text_muted #${colors.textMuted};

       @define-color primary #${colors.primary};
       @define-color on_primary #${colors.onPrimary};

       @define-color accent #${colors.accent};
       @define-color success #${colors.success};
       @define-color warning #${colors.warning};
       @define-color error #${colors.error};
       @define-color on_error #${colors.onError};

       * {
         border: none;
         border-radius: ${toString geometry.radius}px;
         min-height: 0;

         font-family: ${toString typography.monospace};
         font-size: 12px;
         font-weight: 500;
       }

       window#waybar {
         background: @background;
         color: @text_color;

         border-bottom: ${toString geometry.borderWidth}px solid @border_color;
       }

       #workspaces,
       #clock,
       #network,
       #battery {
         margin: 3px 2px;
         padding: 0 8px;

         background: @surface;
         border: ${toString geometry.borderWidth}px solid @border_color;
       }

       #workspaces {
         padding: 0;
       }

       #workspaces button {
         padding: 0 7px;

         color: @text_muted;

         background: transparent;
         background-image: none;

         box-shadow: none;
         text-shadow: none;
       }

       #workspaces button:hover {
         color: @text;

         background-color: @border_color;
         background-image: none;
       }

       #workspaces button.active,
       #workspaces button.visible,
       #workspaces button.focus {
         color: @on_primary;

         background-color: @primary;
         background-image: none;
         border: ${toString geometry.borderWidth}px solid @primary;
       }

       #workspaces button.active label,
       #workspaces button.visible label,
       #workspaces button.focus label {
         color: @on_primary;
       }

       #workspaces button.urgent {
         color: @on_error;

         background: @error;
         background-image: none;
       }

      #clock {
        color: @accent;
        font-weight: 600;
      }

      #network.disconneted {
        color: @error;
      }

      #battery.chargin,
      #battery.plugged {
        color: @succes;
      }

      #battery.warning {
        color: @warning;
      }

      #battery.critical {
        color: @error;
      }

      tooltip {
        background: @surface;
        border: ${toString geometry.borderWidth}px solid @accent;
      }

      toolpit label {
        color: @text_color;
      }
    '';
  };
}
