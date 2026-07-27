import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int temperatureC: 0
	property string sensorName: "--"

	readonly property int filledSegments: Math.max(0, Math.min(10, Math.ceil(temperatureC / 10)))
	readonly property string thermalMode: temperatureC > 85 ? "HOT" : (temperatureC > 65 ? "WARM" : "NOMINAL")

	function updateStats(): void {
		if (!thermalProcess.running)
			thermalProcess.exec(thermalProcess.command);
	}

	function parseThermal(value: string): void {
		const fields = value.trim().split(/\s+/);
		if (fields.length < 2)
			return;

		const parsed = Number.parseInt(fields[0], 10);
		if (!Number.isNaN(parsed))
			temperatureC = Math.max(0, parsed);
		sensorName = fields.slice(1).join(" ");
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

		command: ["bash", "-c", "best=0; label=UNKNOWN; for d in /sys/class/hwmon/hwmon*; do name=$(cat \"$d/name\" 2>/dev/null || echo hwmon); for f in \"$d\"/temp*_input; do [ -r \"$f\" ] || continue; raw=$(cat \"$f\" 2>/dev/null || echo 0); c=$((raw / 1000)); base=${f%_input}; tlabel=$(cat \"${base}_label\" 2>/dev/null || basename \"$base\"); if [ \"$c\" -gt \"$best\" ]; then best=$c; label=\"$name:$tlabel\"; fi; done; done; printf '%s %s\\n' \"$best\" \"$label\""]
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
			title: "THERMAL STATUS"
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
				unit: "TEMP"
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
				value: root.sensorName
			}
		}
	}
}
