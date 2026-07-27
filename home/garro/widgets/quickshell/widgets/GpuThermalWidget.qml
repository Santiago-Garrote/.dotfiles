import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int temperatureC: 0
	property string powerWatts: "--"

	readonly property int filledSegments: Math.max(0, Math.min(10, Math.ceil(temperatureC / 10)))
	readonly property string thermalMode: temperatureC > 85 ? "HOT" : (temperatureC > 65 ? "WARM" : "NOMINAL")

	function updateStats(): void {
		if (!gpuThermalProcess.running)
			gpuThermalProcess.exec(gpuThermalProcess.command);
	}

	function parseGpuThermal(value: string): void {
		const fields = value.trim().split(/\s+/);
		if (fields.length < 2)
			return;

		const temp = Number.parseInt(fields[0], 10);
		const power = Number.parseInt(fields[1], 10);
		temperatureC = Number.isNaN(temp) ? 0 : Math.max(0, Math.round(temp / 1000));
		powerWatts = Number.isNaN(power) ? "--" : (power / 1000000).toFixed(1);
	}

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	Process {
		id: gpuThermalProcess

		command: ["bash", "-c", "for d in /sys/class/hwmon/hwmon*; do name=$(cat \"$d/name\" 2>/dev/null || true); [ \"$name\" = amdgpu ] || continue; temp=$(cat \"$d/temp1_input\" 2>/dev/null || echo 0); power=$(cat \"$d/power1_input\" 2>/dev/null || echo 0); printf '%s %s\\n' \"$temp\" \"$power\"; exit 0; done; printf '0 0\\n'"]
		stdout: StdioCollector {
			id: gpuThermalOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseGpuThermal(gpuThermalOutput.text);
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
			title: "GPU THERMAL"
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
				unit: "GPU"
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
				name: "POWER"
				value: root.powerWatts + "W"
			}
		}
	}
}
