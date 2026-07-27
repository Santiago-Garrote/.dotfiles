import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int storagePercent: 0
	property string storageUsed: "--"
	property string storageTotal: "--"

	readonly property int filledSegments: Math.ceil(storagePercent / 10)
	readonly property string storageMode: storagePercent > 85 ? "LOW SPACE" : (storagePercent > 65 ? "WATCH" : "NOMINAL")

	function updateStats(): void {
		if (!storageProcess.running)
			storageProcess.exec(storageProcess.command);
	}

	function parseStorage(value: string): void {
		const rows = value.trim().split("\n");
		if (rows.length < 2)
			return;

		const fields = rows[1].trim().split(/\s+/);
		if (fields.length < 5)
			return;

		const parsed = Number.parseInt(fields[4].replace("%", ""), 10);
		storagePercent = Number.isNaN(parsed) ? 0 : Math.max(0, Math.min(100, parsed));
		storageUsed = fields[2];
		storageTotal = fields[1];
	}

	Timer {
		interval: 30000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	Process {
		id: storageProcess

		command: ["df", "-P", "-h", "/"]
		stdout: StdioCollector {
			id: storageOutput
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseStorage(storageOutput.text);
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
			title: "STORAGE STATUS"
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
				value: root.storagePercent + "%"
				unit: "ROOT"
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
				value: root.storageMode
			}

			StatusLine {
				theme: root.theme
				name: "USED"
				value: root.storageUsed + "/" + root.storageTotal
			}
		}
	}
}
