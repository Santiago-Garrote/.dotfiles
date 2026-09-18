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
	property var inputMask: null
	// Extra per-edge margin on top of `margin`/offsets, independent of the
	// placement string. Used to carve out a fixed zone on one side of the
	// screen (e.g. reserving space for a sibling panel) without disturbing
	// the other edges.
	property int insetLeft: 0
	property int insetRight: 0
	property int insetTop: 0
	property int insetBottom: 0
	// Every other widget here is a read-only, click-through readout; opting
	// a specific instance into this is what lets it actually take keyboard
	// input (e.g. the embedded terminal widget).
	property bool keyboardFocusable: false

	implicitWidth: windowWidth
	implicitHeight: windowHeight
	color: "transparent"
	mask: inputMask
	exclusionMode: ExclusionMode.Ignore
	focusable: keyboardFocusable
	aboveWindows: false

	WlrLayershell.layer: WlrLayer.Background
	WlrLayershell.namespace: "quickshell-desktop-widgets"
	WlrLayershell.keyboardFocus: keyboardFocusable ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

	readonly property bool fill: placement === "fill"

	anchors {
		left: root.fill || placement.indexOf("left") !== -1
		right: root.fill || placement.indexOf("right") !== -1
		top: root.fill || placement.indexOf("top") !== -1
		bottom: root.fill || placement.indexOf("bottom") !== -1
	}

	margins {
		left: margin + (placement.indexOf("left") !== -1 ? offsetX : 0) + insetLeft
		right: margin + (placement.indexOf("right") !== -1 ? offsetX : 0) + insetRight
		top: margin + (placement.indexOf("top") !== -1 ? offsetY : 0) + insetTop
		bottom: margin + (placement.indexOf("bottom") !== -1 ? offsetY : 0) + insetBottom
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
