import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property string deviceName: ""
	property int rxRate: 0
	property int txRate: 0
	property real previousRxBytes: -1
	property real previousTxBytes: -1
	property real previousSampleMs: -1

	readonly property int totalRate: rxRate + txRate
	readonly property int filledSegments: Math.max(0, Math.min(10, Math.ceil(totalRate / 1048576)))
	readonly property string trafficMode: totalRate > 5242880 ? "BURST" : (totalRate > 0 ? "ACTIVE" : "IDLE")

	function updateStats(): void {
		if (!deviceProcess.running)
			deviceProcess.exec(deviceProcess.command);
		netFile.reload();
	}

	function formatRate(bytesPerSecond: int): string {
		if (bytesPerSecond >= 1048576)
			return (bytesPerSecond / 1048576).toFixed(1) + "M/s";
		return Math.round(bytesPerSecond / 1024) + "K/s";
	}

	function parseDevice(value: string): void {
		const rows = value.trim().split("\n");

		for (const row of rows) {
			const fields = row.split(":");
			if (fields.length < 3)
				continue;
			if (fields[1] !== "loopback" && fields[2].indexOf("connected") === 0) {
				deviceName = fields[0];
				return;
			}
		}

		deviceName = "";
	}

	function parseTraffic(value: string): void {
		if (deviceName.length === 0)
			return;

		const rows = value.trim().split("\n");
		const now = Date.now();

		for (const row of rows) {
			const parts = row.split(":");
			if (parts.length !== 2 || parts[0].trim() !== deviceName)
				continue;

			const fields = parts[1].trim().split(/\s+/);
			if (fields.length < 16)
				return;

			const rxBytes = Number.parseInt(fields[0], 10);
			const txBytes = Number.parseInt(fields[8], 10);
			if (Number.isNaN(rxBytes) || Number.isNaN(txBytes))
				return;

			if (previousSampleMs > 0) {
				const seconds = Math.max(1, (now - previousSampleMs) / 1000);
				rxRate = Math.max(0, Math.round((rxBytes - previousRxBytes) / seconds));
				txRate = Math.max(0, Math.round((txBytes - previousTxBytes) / seconds));
			}

			previousRxBytes = rxBytes;
			previousTxBytes = txBytes;
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

	Process {
		id: deviceProcess

		command: ["nmcli", "-t", "-f", "DEVICE,TYPE,STATE", "device", "status"]
		stdout: StdioCollector {
			id: deviceOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseDevice(deviceOutput.text);
		}
	}

	FileView {
		id: netFile

		path: "/proc/net/dev"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseTraffic(text())
		onTextChanged: root.parseTraffic(text())
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "NETWORK TRAFFIC"
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
				value: root.trafficMode
			}

			StatusLine {
				theme: root.theme
				name: "RX"
				value: root.formatRate(root.rxRate)
			}

			StatusLine {
				theme: root.theme
				name: "TX"
				value: root.formatRate(root.txRate)
			}
		}
	}
}
