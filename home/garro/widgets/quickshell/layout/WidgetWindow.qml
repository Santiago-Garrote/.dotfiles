import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
	id: root

	required property QtObject theme
	default property alias content: content.data

	property string placement: "top-right"
	property int margin: 0
	property int offsetX: 0
	property int offsetY: 0
	property int windowWidth: 280
	property int windowHeight: 92
	property bool shown: true

	implicitWidth: windowWidth
	implicitHeight: windowHeight
	color: "transparent"
	exclusionMode: ExclusionMode.Ignore
	focusable: false
	aboveWindows: false

	WlrLayershell.layer: WlrLayer.Background
	WlrLayershell.namespace: "quickshell-desktop-widgets"
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

	anchors {
		left: placement.indexOf("left") !== -1
		right: placement.indexOf("right") !== -1
		top: placement.indexOf("top") !== -1
		bottom: placement.indexOf("bottom") !== -1
	}

	margins {
		left: margin + (placement.indexOf("left") !== -1 ? offsetX : 0)
		right: margin + (placement.indexOf("right") !== -1 ? offsetX : 0)
		top: margin + (placement.indexOf("top") !== -1 ? offsetY : 0)
		bottom: margin + (placement.indexOf("bottom") !== -1 ? offsetY : 0)
	}

	Item {
		id: content

		anchors.fill: parent
		opacity: root.shown ? root.theme.opacity.widgetVisible : root.theme.opacity.widgetHidden

		Behavior on opacity {
			NumberAnimation {
				duration: root.theme.motion.enabled ? root.theme.motion.widgetFadeMs : 0
			}
		}
	}
}
