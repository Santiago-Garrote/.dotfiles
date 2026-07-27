import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int averageMhz: 0
	property int peakMhz: 0

	readonly property int filledSegments: Math.max(0, Math.min(10, Math.ceil(averageMhz / 500)))
	readonly property string frequencyMode: averageMhz > 3000 ? "BOOST" : (averageMhz > 1800 ? "ACTIVE" : "IDLE")

	function updateStats(): void {
		if (!frequencyProcess.running)
			frequencyProcess.exec(frequencyProcess.command);
	}

	function parseFrequency(value: string): void {
		const fields = value.trim().split(/\s+/);
		if (fields.length < 2)
			return;

		const avg = Number.parseInt(fields[0], 10);
		const peak = Number.parseInt(fields[1], 10);
		averageMhz = Number.isNaN(avg) ? 0 : Math.max(0, avg);
		peakMhz = Number.isNaN(peak) ? 0 : Math.max(0, peak);
	}

	Timer {
		interval: 3000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	Process {
		id: frequencyProcess

		command: ["bash", "-c", "sum=0; count=0; peak=0; for f in /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq; do [ -r \"$f\" ] || continue; khz=$(cat \"$f\" 2>/dev/null || echo 0); mhz=$((khz / 1000)); sum=$((sum + mhz)); count=$((count + 1)); if [ \"$mhz\" -gt \"$peak\" ]; then peak=$mhz; fi; done; if [ \"$count\" -gt 0 ]; then printf '%s %s\\n' $((sum / count)) \"$peak\"; else printf '0 0\\n'; fi"]
		stdout: StdioCollector {
			id: frequencyOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseFrequency(frequencyOutput.text);
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
			title: "CPU FREQUENCY"
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
				value: root.averageMhz.toString()
				unit: "MHZ"
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
				value: root.frequencyMode
			}

			StatusLine {
				theme: root.theme
				name: "PEAK"
				value: root.peakMhz + "MHZ"
			}
		}
	}
}
