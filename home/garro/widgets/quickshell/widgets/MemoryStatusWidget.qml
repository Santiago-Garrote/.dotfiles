import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int memoryPercent: 0
	property string memoryUsed: "--"
	property string memoryTotal: "--"

	readonly property int filledSegments: Math.ceil(memoryPercent / 10)
	readonly property string memoryMode: memoryPercent > 80 ? "PRESSURE" : (memoryPercent > 55 ? "ACTIVE" : "NOMINAL")

	function updateStats(): void {
		memoryFile.reload();
	}

	function formatGiB(kib: int): string {
		return (kib / 1024 / 1024).toFixed(1) + "G";
	}

	function parseMemory(value: string): void {
		const rows = value.trim().split("\n");
		let total = -1;
		let available = -1;

		for (const row of rows) {
			const fields = row.trim().split(/\s+/);
			if (fields.length < 2)
				continue;
			if (fields[0] === "MemTotal:")
				total = Number.parseInt(fields[1], 10);
			if (fields[0] === "MemAvailable:")
				available = Number.parseInt(fields[1], 10);
		}

		if (total > 0 && available >= 0) {
			const used = total - available;
			memoryPercent = Math.max(0, Math.min(100, Math.round((used / total) * 100)));
			memoryUsed = formatGiB(used);
			memoryTotal = formatGiB(total);
		}
	}

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	FileView {
		id: memoryFile

		path: "/proc/meminfo"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseMemory(text())
		onTextChanged: root.parseMemory(text())
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "MEMORY STATUS"
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
				value: root.memoryPercent + "%"
				unit: "RAM"
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
				value: root.memoryMode
			}

			StatusLine {
				theme: root.theme
				name: "USED"
				value: root.memoryUsed + "/" + root.memoryTotal
			}
		}
	}
}
