import QtQuick
import Quickshell.Hyprland._Ipc
import "../components"

Item {
	id: root

	required property QtObject theme

	readonly property var workspace: Hyprland.focusedWorkspace
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

		Item {
			anchors.horizontalCenter: parent.horizontalCenter
			width: 96
			height: 42

			Text {
				anchors.centerIn: parent
				text: root.workspaceLabel
				color: root.theme.colors.accent
				font.family: root.theme.fonts.display
				font.pixelSize: 42
				font.letterSpacing: 0
				opacity: 0.24
			}

			Text {
				anchors.centerIn: parent
				text: root.workspaceLabel
				color: root.theme.colors.accent
				font.family: root.theme.fonts.display
				font.pixelSize: 42
				font.letterSpacing: 0
				opacity: 0.96
			}
		}
	}
}
