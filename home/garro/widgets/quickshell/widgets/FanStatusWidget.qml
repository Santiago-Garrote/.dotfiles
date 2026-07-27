import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int fanRpm: 0
	property int fanCount: 0

	readonly property int filledSegments: Math.max(0, Math.min(10, Math.ceil(fanRpm / 600)))
	readonly property string fanMode: fanCount === 0 ? "NO SENSOR" : (fanRpm > 0 ? "ACTIVE" : "IDLE")

	function updateStats(): void {
		if (!fanProcess.running)
			fanProcess.exec(fanProcess.command);
	}

	function parseFans(value: string): void {
		const fields = value.trim().split(/\s+/);
		if (fields.length < 2)
			return;

		const rpm = Number.parseInt(fields[0], 10);
		const count = Number.parseInt(fields[1], 10);
		fanRpm = Number.isNaN(rpm) ? 0 : Math.max(0, rpm);
		fanCount = Number.isNaN(count) ? 0 : Math.max(0, count);
	}

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	Process {
		id: fanProcess

		command: ["bash", "-c", "max=0; count=0; for f in /sys/class/hwmon/hwmon*/fan*_input; do [ -r \"$f\" ] || continue; rpm=$(cat \"$f\" 2>/dev/null || echo 0); count=$((count + 1)); if [ \"$rpm\" -gt \"$max\" ]; then max=$rpm; fi; done; printf '%s %s\\n' \"$max\" \"$count\""]
		stdout: StdioCollector {
			id: fanOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseFans(fanOutput.text);
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
			title: "FAN STATUS"
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
				value: root.fanRpm.toString()
				unit: "RPM"
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
				value: root.fanMode
			}

			StatusLine {
				theme: root.theme
				name: "FANS"
				value: root.fanCount.toString()
			}
		}
	}
}
