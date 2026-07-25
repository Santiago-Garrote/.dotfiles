import QtQuick
import Quickshell.Hyprland._Ipc
import "../components"

Panel {
	id: root

	readonly property var workspace: Hyprland.focusedWorkspace
	readonly property string workspaceLabel: workspace !== null ? workspace.id.toString() : "--"

	Rectangle {
		anchors.centerIn: parent
		width: 84
		height: 28
		radius: theme.cornerRadius
		border.width: theme.borderWidth
		border.color: theme.colors.accent
		color: theme.colors.background

		Label {
			anchors.centerIn: parent
			theme: root.theme
			text: "WS " + root.workspaceLabel
			textColor: theme.colors.accent
			size: theme.fontSizes.small
		}
	}
}
