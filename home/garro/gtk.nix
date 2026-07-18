{ theme, ... }:

let
  colors = theme.colors;
  geometry = theme.geometry;
  typography = theme.typography;
in
{
  gtk = {
    enable = true;

    colorScheme = "dark";

    font = {
      name = typography.interface;
      size = 10;
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-button-images = false;
        gtk-menu-images = false;
        gtk-enable-animations = theme.motion.enabled;
      };

      extraCss = ''
        @define-color theme_bg_color #${colors.background};
        @define-color theme_fg_color #${colors.text};

        @define-color theme_base_color #${colors.surface};
        @define-color theme_text_color #${colors.text};

        @define-color theme_selected_bg_color #${colors.primary};
        @define-color theme_selected_fg_color #${colors.onPrimary};

        @define-color borders #${colors.border};

        @define-color success_color #${colors.success};
        @define-color warning_color #${colors.warning};
        @define-color error_color #${colors.error};

        selection {
          background-color: #${colors.selection};
          color: #${colors.onSelection};
        }

        tooltip {
          background-color: #${colors.surface};
          color: #${colors.text};
          border: ${toString geometry.borderWidth}px solid #${colors.border};
          border-radius: ${toString geometry.radius}px;
        }
      '';
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-enable-animations = theme.motion.enabled;
      };

      extraCss = ''
        @define-color window_bg_color #${colors.background};
        @define-color window_fg_color #${colors.text};

        @define-color view_bg_color #${colors.surface};
        @define-color view_fg_color #${colors.text};

        @define-color headerbar_bg_color #${colors.surface};
        @define-color headerbar_fg_color #${colors.text};

        @define-color accent_color #${colors.primary};
        @define-color accent_bg_color #${colors.primary};
        @define-color accent_fg_color #${colors.onPrimary};

        @define-color borders #${colors.border};

        @define-color success_color #${colors.success};
        @define-color warning_color #${colors.warning};
        @define-color error_color #${colors.error};

        selection {
          background-color: #${colors.selection};
          color: #${colors.onSelection};
        }

        tooltip {
          background-color: #${colors.surface};
          color: #${colors.text};
          border: ${toString geometry.borderWidth}px solid #${colors.border};
          border-radius: ${toString geometry.radius}px;
        }
      '';
    };
  };
}
