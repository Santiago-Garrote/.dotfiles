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

		Label {
			theme: root.theme
			text: "BATTERY STATUS"
			textColor: root.theme.colors.accent
			size: root.theme.fontSizes.large
			anchors.horizontalCenter: parent.horizontalCenter
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

			Row {
				anchors.verticalCenter: parent.verticalCenter
				spacing: 3

				Repeater {
					model: 10

					Rectangle {
						required property int index

						width: 21
						height: 34
						color: index < root.filledSegments ? root.theme.colors.accent : "transparent"
						border.color: root.theme.colors.accent
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
					textColor: root.theme.colors.accent
					size: root.theme.fontSizes.large
					anchors.horizontalCenter: parent.horizontalCenter
				}

				Label {
					theme: root.theme
					text: "CAP"
					textColor: root.theme.colors.accent
					size: root.theme.fontSizes.small
					anchors.horizontalCenter: parent.horizontalCenter
				}
			}
		}

		Rectangle {
			width: 300
			height: root.theme.borderWidth
			color: root.theme.colors.accent
			opacity: 0.62
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Column {
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: root.theme.spacing.small

			Label {
				theme: root.theme
				text: "MODE: " + root.batteryMode
				textColor: root.theme.colors.accent
				size: root.theme.fontSizes.medium
				anchors.horizontalCenter: parent.horizontalCenter
			}

			Label {
				theme: root.theme
				text: "EST TIME: --"
				textColor: root.theme.colors.accent
				size: root.theme.fontSizes.medium
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
	}
}
