import Quickshell
import Quickshell.Hyprland._Ipc
import QtQuick
import "../widgets"

Scope {
	id: root

	required property QtObject theme
	readonly property var workspace: Hyprland.focusedWorkspace
	readonly property bool widgetsVisible: workspace !== null
		&& workspace.toplevels !== null
		&& workspace.toplevels.values.length === 0

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: 280
		windowHeight: 92
		margin: root.theme.spacing.gapOuter

		ClockWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: 300
		windowHeight: 68
		margin: root.theme.spacing.gapOuter

		WorkspaceWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}
}
