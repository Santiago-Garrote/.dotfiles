import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property string batteryName: "BAT0"
	property int batteryPercent: -1
	property string batteryStatus: ""

	readonly property string batteryMode: formatMode(batteryStatus)
	readonly property int filledSegments: batteryPercent >= 0 ? Math.ceil(batteryPercent / 10) : 0

	function updateCapacity(): void {
		batteryPercent = parsePercent(capacityFile.text());
	}

	function updateStatus(): void {
		batteryStatus = statusFile.text().trim();
	}

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
		interval: 10000
		running: true
		repeat: true
		triggeredOnStart: true
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
		onLoaded: root.updateCapacity()
		onTextChanged: root.updateCapacity()
	}

	FileView {
		id: statusFile

		path: "/sys/class/power_supply/" + root.batteryName + "/status"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.updateStatus()
		onTextChanged: root.updateStatus()
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "BATTERY STATUS"
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			height: 46
			spacing: root.theme.spacing.medium

			Rectangle {
				width: 24
				height: 38
				anchors.verticalCenter: parent.verticalCenter
				color: "transparent"
				border.color: root.theme.colors.accent
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
					color: root.theme.colors.accent
				}

				Label {
					anchors.centerIn: parent
					theme: root.theme
					text: "+"
					textColor: root.theme.colors.accent
					size: root.theme.fontSizes.medium
				}
			}

			SegmentBar {
				theme: root.theme
				filledSegments: root.filledSegments
			}

			MetricReadout {
				theme: root.theme
				value: root.batteryPercent >= 0 ? root.batteryPercent + "%" : "--%"
				unit: "CAP"
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
				value: root.batteryMode
			}

			StatusLine {
				theme: root.theme
				name: "EST TIME"
				value: "--"
			}
		}
	}
}
