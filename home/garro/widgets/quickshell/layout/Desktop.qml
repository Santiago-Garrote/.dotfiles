import Quickshell
import QtQuick
import "../widgets"

Scope {
	id: root

	required property QtObject theme

	FloatingWindow {
		id: clockWindow

		title: "Desktop clock"
		implicitWidth: 280
		implicitHeight: 92
		color: "transparent"

		ClockWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}
}
