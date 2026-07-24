{ theme }:

{
  programs.wlogout.style = ''
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
}
