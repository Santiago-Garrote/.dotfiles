{ theme }:

{
  xdg.configFile."quickshell/Theme.qml".text = ''
    import QtQuick

    QtObject {
      readonly property QtObject colors: QtObject {
        readonly property color background: "#${theme.colors.background}"
        readonly property color surface: "#${theme.colors.surface}"
        readonly property color border: "#${theme.colors.border}"
        readonly property color foreground: "#${theme.colors.foreground}"
        readonly property color muted: "#${theme.colors.muted}"
        readonly property color accent: "#${theme.colors.accent}"
      }

      readonly property QtObject spacing: QtObject {
        readonly property int small: ${toString theme.geometry.spacingSmall}
        readonly property int medium: ${toString theme.geometry.spacingMedium}
        readonly property int gapInner: ${toString theme.geometry.gapInner}
        readonly property int gapOuter: ${toString theme.geometry.gapOuter}
      }

      readonly property int cornerRadius: ${toString theme.geometry.radius}
      readonly property int borderWidth: ${toString theme.geometry.borderWidth}

      readonly property QtObject fonts: QtObject {
        readonly property string ui: "${theme.typography.interface}"
        readonly property string monospace: "${theme.typography.monospace}"
      }

      readonly property QtObject fontSizes: QtObject {
        readonly property int small: 10
        readonly property int medium: 12
        readonly property int large: 14
      }

      readonly property QtObject sizes: QtObject {
        readonly property int barHeight: 30
      }
    }
  '';
}
