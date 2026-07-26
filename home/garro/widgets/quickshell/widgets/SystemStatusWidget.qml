import QtQuick
import Quickshell.Io
import "../components"

Panel {
	id: root

	property string batteryName: "BAT0"
	readonly property int batteryPercent: parsePercent(capacityFile.text())
	readonly property string batteryStatus: statusFile.text().trim()
	readonly property string batteryMode: formatMode(batteryStatus)
	readonly property color batteryColor: batteryPercent >= 0 && batteryPercent <= 15 && batteryStatus !== "Charging" ? theme.colors.muted : theme.colors.accent
	readonly property int filledSegments: batteryPercent >= 0 ? Math.ceil(batteryPercent / 10) : 0

	function parsePercent(value: string): int {
		const parsed = Number.parseInt(value.trim(), 10);
		return Number.isNaN(parsed) ? -1 : Math.max(0, Math.min(100, parsed));
	}

	function formatMode(status: string): string {
		if (status === "Charging")
			return "CHARGE";
		if (status === "Discharging")
			return "DISCHARGE";
		if (status === "Full")
			return "FULL";
		if (status === "Not charging")
			return "HOLD";
		return status.length > 0 ? status.toUpperCase() : "UNKNOWN";
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
		spacing: root.theme.spacing.small

		Label {
			theme: root.theme
			text: "BATTERY STATUS"
			textColor: root.theme.colors.accent
			size: root.theme.fontSizes.large
		}

		Row {
			width: parent.width
			height: 46
			spacing: root.theme.spacing.medium

			Rectangle {
				width: 24
				height: 38
				anchors.verticalCenter: parent.verticalCenter
				color: "transparent"
				border.color: root.theme.colors.border
				border.width: root.theme.borderWidth
				radius: root.theme.cornerRadius

				Rectangle {
					width: 10
					height: 3
					anchors {
						horizontalCenter: parent.horizontalCenter
						top: parent.top
						topMargin: -3
					}
					color: root.theme.colors.border
				}

				Label {
					anchors.centerIn: parent
					theme: root.theme
					text: "+"
					textColor: root.theme.colors.muted
					size: root.theme.fontSizes.medium
				}
			}

			Row {
				anchors.verticalCenter: parent.verticalCenter
				spacing: 3

				Repeater {
					model: 10

					Rectangle {
						required property int index

						width: 21
						height: 34
						color: index < root.filledSegments ? root.batteryColor : "transparent"
						border.color: index < root.filledSegments ? root.batteryColor : root.theme.colors.border
						border.width: root.theme.borderWidth
						opacity: index < root.filledSegments ? 0.88 : 0.52
						radius: root.theme.cornerRadius
					}
				}
			}

			Column {
				anchors.verticalCenter: parent.verticalCenter
				spacing: 0

				Label {
					theme: root.theme
					text: root.batteryPercent >= 0 ? root.batteryPercent + "%" : "--%"
					textColor: root.batteryColor
					size: root.theme.fontSizes.large
				}

				Label {
					theme: root.theme
					text: "CAP"
					textColor: root.theme.colors.muted
					size: root.theme.fontSizes.small
				}
			}
		}

		Rectangle {
			width: parent.width
			height: root.theme.borderWidth
			color: root.theme.colors.border
		}

		Column {
			width: parent.width
			spacing: root.theme.spacing.small

			Label {
				theme: root.theme
				text: "MODE: " + root.batteryMode
				textColor: root.theme.colors.foreground
				size: root.theme.fontSizes.medium
			}

			Label {
				theme: root.theme
				text: "EST TIME: --"
				textColor: root.theme.colors.muted
				size: root.theme.fontSizes.medium
			}
		}
	}
}
