import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int gpuPercent: 0
	property int vramPercent: 0
	property string vramUsed: "--"
	property string vramTotal: "--"

	readonly property int filledSegments: Math.ceil(gpuPercent / 10)
	readonly property string gpuMode: gpuPercent > 80 ? "HIGH LOAD" : (gpuPercent > 35 ? "ACTIVE" : "NOMINAL")

	function updateStats(): void {
		if (!gpuProcess.running)
			gpuProcess.exec(gpuProcess.command);
	}

	function formatMiB(bytes: int): string {
		return Math.round(bytes / 1024 / 1024) + "M";
	}

	function parseGpu(value: string): void {
		const fields = value.trim().split(/\s+/);
		if (fields.length < 3)
			return;

		const busy = Number.parseInt(fields[0], 10);
		const used = Number.parseInt(fields[1], 10);
		const total = Number.parseInt(fields[2], 10);
		gpuPercent = Number.isNaN(busy) ? 0 : Math.max(0, Math.min(100, busy));
		if (!Number.isNaN(used) && !Number.isNaN(total) && total > 0) {
			vramPercent = Math.max(0, Math.min(100, Math.round((used / total) * 100)));
			vramUsed = formatMiB(used);
			vramTotal = formatMiB(total);
		}
	}

	Timer {
		interval: 3000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	Process {
		id: gpuProcess

		command: ["bash", "-c", "for d in /sys/class/drm/card*/device; do [ -r \"$d/gpu_busy_percent\" ] || continue; busy=$(cat \"$d/gpu_busy_percent\" 2>/dev/null || echo 0); used=$(cat \"$d/mem_info_vram_used\" 2>/dev/null || echo 0); total=$(cat \"$d/mem_info_vram_total\" 2>/dev/null || echo 0); printf '%s %s %s\\n' \"$busy\" \"$used\" \"$total\"; exit 0; done; printf '0 0 0\\n'"]
		stdout: StdioCollector {
			id: gpuOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseGpu(gpuOutput.text);
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
			title: "GPU STATUS"
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
				value: root.gpuPercent + "%"
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
				value: root.gpuMode
			}

			StatusLine {
				theme: root.theme
				name: "VRAM"
				value: root.vramPercent + "% " + root.vramUsed + "/" + root.vramTotal
			}
		}
	}
}
