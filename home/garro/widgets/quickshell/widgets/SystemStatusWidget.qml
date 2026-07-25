import QtQuick
import Quickshell.Io
import "../components"

Panel {
	id: root

	property string batteryName: "BAT0"
	readonly property int batteryPercent: parsePercent(capacityFile.text())
	readonly property string batteryStatus: statusFile.text().trim()
	readonly property string batteryState: batteryStatus.length > 0 ? batteryStatus.toUpperCase().slice(0, 3) : "BAT"
	readonly property color batteryColor: batteryPercent >= 0 && batteryPercent <= 15 && batteryStatus !== "Charging" ? theme.colors.muted : theme.colors.accent

	function parsePercent(value: string): int {
		const parsed = Number.parseInt(value.trim(), 10);
		return Number.isNaN(parsed) ? -1 : Math.max(0, Math.min(100, parsed));
	}

	Timer {
		interval: 30000
		running: true
		repeat: true
		onTriggered: {
			capacityFile.reload();
			statusFile.reload();
		}
	}

	FileView {
		id: capacityFile

		path: "/sys/class/power_supply/" + root.batteryName + "/capacity"
		preload: true
		blockLoading: true
		printErrors: false
	}

	FileView {
		id: statusFile

		path: "/sys/class/power_supply/" + root.batteryName + "/status"
		preload: true
		blockLoading: true
		printErrors: false
	}

	Column {
		anchors.fill: parent
		spacing: root.theme.spacing.medium

		Row {
			width: parent.width
			spacing: root.theme.spacing.medium

			Label {
				theme: root.theme
				text: "BAT"
				textColor: root.theme.colors.muted
				size: root.theme.fontSizes.small
			}

			Label {
				theme: root.theme
				text: root.batteryPercent >= 0 ? root.batteryPercent + "%" : "--%"
				textColor: root.batteryColor
				size: root.theme.fontSizes.large
			}

			Label {
				theme: root.theme
				text: root.batteryState
				textColor: root.theme.colors.muted
				size: root.theme.fontSizes.small
			}
		}

		Rectangle {
			width: parent.width
			height: 12
			color: root.theme.colors.background
			border.color: root.theme.colors.border
			border.width: root.theme.borderWidth
			radius: root.theme.cornerRadius

			Rectangle {
				anchors {
					left: parent.left
					top: parent.top
					bottom: parent.bottom
					margins: root.theme.borderWidth
				}
				width: root.batteryPercent >= 0 ? Math.max(2, (parent.width - root.theme.borderWidth * 2) * root.batteryPercent / 100) : 0
				color: root.batteryColor
				opacity: 0.82
				radius: root.theme.cornerRadius
			}
		}
	}
}
