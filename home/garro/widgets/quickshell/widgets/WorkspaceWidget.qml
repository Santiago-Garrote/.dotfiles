import QtQuick
import Quickshell.Hyprland._Ipc
import "../components"

Panel {
	id: root

	Row {
		anchors.centerIn: parent
		spacing: theme.spacing.small

		Repeater {
			model: Hyprland.workspaces.values

			Rectangle {
				required property var modelData

				width: 24
				height: 24
				radius: theme.cornerRadius
				border.width: theme.borderWidth
				border.color: modelData.focused ? theme.colors.accent : theme.colors.border
				color: modelData.active ? theme.colors.surface : theme.colors.background

				Label {
					anchors.centerIn: parent
					theme: root.theme
					text: modelData.id.toString()
					textColor: modelData.focused ? theme.colors.accent : theme.colors.muted
					size: theme.fontSizes.small
				}
			}
		}
	}
}
