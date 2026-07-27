import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int readRate: 0
	property int writeRate: 0
	property real previousReadSectors: -1
	property real previousWriteSectors: -1
	property real previousSampleMs: -1

	readonly property int totalRate: readRate + writeRate
	readonly property int filledSegments: Math.max(0, Math.min(10, Math.ceil(totalRate / 10485760)))
	readonly property string diskMode: totalRate > 52428800 ? "BURST" : (totalRate > 0 ? "ACTIVE" : "IDLE")

	function updateStats(): void {
		diskFile.reload();
	}

	function formatRate(bytesPerSecond: int): string {
		if (bytesPerSecond >= 1048576)
			return (bytesPerSecond / 1048576).toFixed(1) + "M/s";
		return Math.round(bytesPerSecond / 1024) + "K/s";
	}

	function parseDisk(value: string): void {
		const rows = value.trim().split("\n");
		const now = Date.now();

		for (const row of rows) {
			const fields = row.trim().split(/\s+/);
			if (fields.length < 14)
				continue;

			const name = fields[2];
			if (name !== "dm-0" && name !== "nvme0n1")
				continue;

			const readSectors = Number.parseInt(fields[5], 10);
			const writeSectors = Number.parseInt(fields[9], 10);
			if (Number.isNaN(readSectors) || Number.isNaN(writeSectors))
				return;

			if (previousSampleMs > 0) {
				const seconds = Math.max(1, (now - previousSampleMs) / 1000);
				readRate = Math.max(0, Math.round(((readSectors - previousReadSectors) * 512) / seconds));
				writeRate = Math.max(0, Math.round(((writeSectors - previousWriteSectors) * 512) / seconds));
			}

			previousReadSectors = readSectors;
			previousWriteSectors = writeSectors;
			previousSampleMs = now;
			return;
		}
	}

	Timer {
		interval: 1000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	FileView {
		id: diskFile

		path: "/proc/diskstats"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseDisk(text())
		onTextChanged: root.parseDisk(text())
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "DISK I/O"
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
				value: root.formatRate(root.totalRate)
				unit: "I/O"
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
				value: root.diskMode
			}

			StatusLine {
				theme: root.theme
				name: "READ"
				value: root.formatRate(root.readRate)
			}

			StatusLine {
				theme: root.theme
				name: "WRITE"
				value: root.formatRate(root.writeRate)
			}
		}
	}
}
