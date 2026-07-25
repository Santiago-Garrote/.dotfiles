import Quickshell
import QtQuick
import "../widgets"

Scope {
	id: root

	required property QtObject theme

	WidgetWindow {
		placement: "top-right"
		windowWidth: 280
		windowHeight: 92
		margin: root.theme.spacing.gapOuter

		ClockWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}
}
