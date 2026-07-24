import Quickshell
import QtQuick
import "components"

PanelWindow {
	Theme {
		id: theme
	}

	anchors {
		top: true
		left: true
		right: true
	}

	implicitHeight: theme.sizes.barHeight

	Bar {
		anchors.fill: parent
		theme: theme
	}
}
