import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int cpuPercent: 0
	property string loadAverage: "--"
	property real previousCpuIdle: -1
	property real previousCpuTotal: -1

	readonly property int filledSegments: Math.ceil(cpuPercent / 10)
	readonly property string cpuMode: cpuPercent > 80 ? "HIGH LOAD" : (cpuPercent > 45 ? "ACTIVE" : "NOMINAL")

	function updateStats(): void {
		statFile.reload();
		loadFile.reload();
	}

	function parseCpu(value: string): void {
		const rows = value.trim().split("\n");
		if (rows.length === 0)
			return;

		const fields = rows[0].trim().split(/\s+/);
		if (fields.length < 8 || fields[0] !== "cpu")
			return;

		const user = Number.parseInt(fields[1], 10);
		const nice = Number.parseInt(fields[2], 10);
		const system = Number.parseInt(fields[3], 10);
		const idle = Number.parseInt(fields[4], 10);
		const iowait = Number.parseInt(fields[5], 10);
		const irq = Number.parseInt(fields[6], 10);
		const softirq = Number.parseInt(fields[7], 10);
		const steal = fields.length > 8 ? Number.parseInt(fields[8], 10) : 0;
		const total = user + nice + system + idle + iowait + irq + softirq + steal;
		const idleTotal = idle + iowait;

		if (previousCpuTotal >= 0) {
			const totalDelta = total - previousCpuTotal;
			const idleDelta = idleTotal - previousCpuIdle;
			if (totalDelta > 0)
				cpuPercent = Math.max(0, Math.min(100, Math.round((1 - idleDelta / totalDelta) * 100)));
		}

		previousCpuTotal = total;
		previousCpuIdle = idleTotal;
	}

	function parseLoad(value: string): void {
		const fields = value.trim().split(/\s+/);
		loadAverage = fields.length > 0 ? fields[0] : "--";
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	FileView {
		id: statFile

		path: "/proc/stat"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseCpu(text())
		onTextChanged: root.parseCpu(text())
	}

	FileView {
		id: loadFile

		path: "/proc/loadavg"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseLoad(text())
		onTextChanged: root.parseLoad(text())
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "CPU STATUS"
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
				value: root.cpuPercent + "%"
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
				value: root.cpuMode
			}

			StatusLine {
				theme: root.theme
				name: "LOAD"
				value: root.loadAverage
			}
		}
	}
}
