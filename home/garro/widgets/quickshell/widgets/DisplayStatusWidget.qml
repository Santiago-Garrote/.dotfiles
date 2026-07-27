import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int monitorCount: 0
	property string displayName: "--"
	property string resolution: "--"
	property string refreshRate: "--"
	property string activeWorkspace: "--"

	readonly property int filledSegments: Math.max(0, Math.min(10, monitorCount))
	readonly property string displayMode: monitorCount > 0 ? "ONLINE" : "OFFLINE"

	function updateStats(): void {
		if (!displayProcess.running)
			displayProcess.exec(displayProcess.command);
	}

	function parseDisplay(value: string): void {
		try {
			const monitors = JSON.parse(value);
			monitorCount = monitors.length;
			if (monitors.length === 0)
				return;

			let focused = monitors[0];
			for (const monitor of monitors) {
				if (monitor.focused) {
					focused = monitor;
					break;
				}
			}
			displayName = focused.name;
			resolution = focused.width + "x" + focused.height;
			refreshRate = Math.round(focused.refreshRate).toString() + "HZ";
			activeWorkspace = focused.activeWorkspace !== undefined ? focused.activeWorkspace.name : "--";
		} catch (error) {
			monitorCount = 0;
		}
	}

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	Process {
		id: displayProcess

		command: ["hyprctl", "-j", "monitors"]
		stdout: StdioCollector {
			id: displayOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseDisplay(displayOutput.text);
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
			title: "DISPLAY STATUS"
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
				value: root.monitorCount.toString()
				unit: "MON"
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
				name: root.displayName
				value: root.resolution
			}

			StatusLine {
				theme: root.theme
				name: "MODE"
				value: root.displayMode + " " + root.refreshRate
			}
		}
	}
}
