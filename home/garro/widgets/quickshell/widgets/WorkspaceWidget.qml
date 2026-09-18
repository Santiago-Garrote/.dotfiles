import QtQuick
import Quickshell.Hyprland._Ipc
import "../components"

Item {
	id: root

	required property QtObject theme

	readonly property var workspace: Hyprland.focusedWorkspace
	readonly property int workspaceValue: workspace !== null ? workspace.id : 0
	readonly property string workspaceLabel: workspace !== null ? workspace.id.toString() : "--"

	Column {
		anchors.centerIn: parent
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "WORKSPACE"
			titleSize: root.theme.fontSizes.small
		}

		ReadoutDivider {
			theme: root.theme
			dividerWidth: 120
		}

		BitColumn {
			anchors.horizontalCenter: parent.horizontalCenter
			theme: root.theme
			value: root.workspaceValue
			horizontal: true
		}

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			theme: root.theme
			text: root.workspaceLabel
			size: root.theme.fontSizes.small
		}
	}
}
