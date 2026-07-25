import Quickshell
import QtQuick
import "components"
import "widgets"

FloatingWindow {
	id: root

	Theme {
		id: theme
	}

	title: "Desktop widgets"
	implicitWidth: 280
	implicitHeight: 92
	color: "transparent"

	ClockWidget {
		anchors.fill: parent
		theme: theme
	}
}
