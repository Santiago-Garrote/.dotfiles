import QtQuick
import Quickshell.Hyprland._Ipc
import "../components"

Item {
	id: root

	required property QtObject theme

	readonly property var workspace: Hyprland.focusedWorkspace
	readonly property int windowCount: workspace !== null && workspace.toplevels !== null ? workspace.toplevels.values.length : 0
	readonly property int filledSegments: Math.max(0, Math.min(10, windowCount))
	readonly property string windowMode: windowCount === 0 ? "DESKTOP" : (windowCount > 5 ? "DENSE" : "ACTIVE")
	readonly property string workspaceLabel: workspace !== null ? workspace.id.toString() : "--"

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "WINDOW STATE"
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			height: 46
			spacing: root.theme.spacing.medium

			SegmentBar {
				theme: root.theme
				filledSegments: root.filledSegments
			}

			MetricReadout {
				theme: root.theme
				value: root.windowCount.toString()
				unit: "WIN"
			}
		}

		ReadoutDivider {
			theme: root.theme
		}

		Column {
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: root.theme.spacing.small

			StatusLine {
				theme: root.theme
				name: "MODE"
				value: root.windowMode
			}

			StatusLine {
				theme: root.theme
				name: "WS"
				value: root.workspaceLabel
			}
		}
	}
}
