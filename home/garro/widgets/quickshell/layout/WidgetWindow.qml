import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
	id: root

	default property alias content: content.data

	property string placement: "top-right"
	property int margin: 0
	property int windowWidth: 280
	property int windowHeight: 92

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
		left: margin
		right: margin
		top: margin
		bottom: margin
	}

	Item {
		id: content

		anchors.fill: parent
	}
}
