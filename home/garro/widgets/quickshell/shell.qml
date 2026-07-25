import Quickshell
import QtQuick
import "components"

FloatingWindow {
	id: root

	Theme {
		id: theme
	}

	title: "Desktop widgets"
	width: 280
	height: 92
	color: "transparent"

	StatusWidget {
		anchors.fill: parent
		theme: theme
	}
}
