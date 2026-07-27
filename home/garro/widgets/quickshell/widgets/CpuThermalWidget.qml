import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int temperatureC: 0

	readonly property int filledSegments: Math.max(0, Math.min(10, Math.ceil(temperatureC / 10)))
	readonly property string thermalMode: temperatureC > 85 ? "HOT" : (temperatureC > 65 ? "WARM" : "NOMINAL")

	function updateStats(): void {
		if (!thermalProcess.running)
			thermalProcess.exec(thermalProcess.command);
	}

	function parseThermal(value: string): void {
		const parsed = Number.parseInt(value.trim(), 10);
		temperatureC = Number.isNaN(parsed) ? 0 : Math.max(0, Math.round(parsed / 1000));
	}

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	Process {
		id: thermalProcess

		command: ["bash", "-c", "for d in /sys/class/hwmon/hwmon*; do name=$(cat \"$d/name\" 2>/dev/null || true); [ \"$name\" = k10temp ] || continue; cat \"$d/temp1_input\" 2>/dev/null || echo 0; exit 0; done; printf '0\\n'"]
		stdout: StdioCollector {
			id: thermalOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseThermal(thermalOutput.text);
		}
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "CPU THERMAL"
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
				value: root.temperatureC + "C"
				unit: "CPU"
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
				value: root.thermalMode
			}

			StatusLine {
				theme: root.theme
				name: "SENSOR"
				value: "K10TEMP"
			}
		}
	}
}
