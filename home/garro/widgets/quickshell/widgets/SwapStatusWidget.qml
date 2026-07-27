import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int swapPercent: 0
	property string swapUsed: "--"
	property string swapTotal: "--"

	readonly property int filledSegments: Math.ceil(swapPercent / 10)
	readonly property string swapMode: swapTotal === "0.0G" ? "DISABLED" : (swapPercent > 50 ? "ACTIVE" : "IDLE")

	function updateStats(): void {
		memoryFile.reload();
	}

	function formatGiB(kib: int): string {
		return (kib / 1024 / 1024).toFixed(1) + "G";
	}

	function parseSwap(value: string): void {
		const rows = value.trim().split("\n");
		let total = -1;
		let free = -1;

		for (const row of rows) {
			const fields = row.trim().split(/\s+/);
			if (fields.length < 2)
				continue;
			if (fields[0] === "SwapTotal:")
				total = Number.parseInt(fields[1], 10);
			if (fields[0] === "SwapFree:")
				free = Number.parseInt(fields[1], 10);
		}

		if (total >= 0 && free >= 0) {
			const used = total - free;
			swapPercent = total > 0 ? Math.max(0, Math.min(100, Math.round((used / total) * 100))) : 0;
			swapUsed = formatGiB(used);
			swapTotal = formatGiB(total);
		}
	}

	Timer {
		interval: 10000
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
		onLoaded: root.parseSwap(text())
		onTextChanged: root.parseSwap(text())
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "SWAP STATUS"
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
				value: root.swapPercent + "%"
				unit: "SWAP"
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
				value: root.swapMode
			}

			StatusLine {
				theme: root.theme
				name: "USED"
				value: root.swapUsed + "/" + root.swapTotal
			}
		}
	}
}
