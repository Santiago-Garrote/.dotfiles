import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int pointerX: 0
	property int pointerY: 0
	property bool tracking: false

	readonly property int filledSegments: tracking ? 10 : 0
	readonly property string pointerMode: tracking ? "GLOBAL" : "WAITING"

	function refreshPointer() {
		if (!pointerProcess.running)
			pointerProcess.exec(pointerProcess.command);
	}

	function parseCursorPosition(output) {
		const parts = output.trim().split(/[,\s]+/);
		if (parts.length < 2)
			return;

		const nextX = Number.parseInt(parts[0], 10);
		const nextY = Number.parseInt(parts[1], 10);
		if (Number.isNaN(nextX) || Number.isNaN(nextY))
			return;

		pointerX = nextX;
		pointerY = nextY;
		tracking = true;
	}

	Timer {
		interval: 100
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.refreshPointer()
	}

	Process {
		id: pointerProcess

		command: ["hyprctl", "cursorpos"]

		stdout: StdioCollector {
			id: pointerOutput
			waitForEnd: true
		}

		stderr: StdioCollector {
			waitForEnd: true
		}

		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseCursorPosition(pointerOutput.text);
			else
				root.tracking = false;
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
			title: "POINTER GLOBAL"
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
				value: root.pointerX.toString()
				unit: "X"
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
				value: root.pointerMode
			}

			StatusLine {
				theme: root.theme
				name: "Y"
				value: root.pointerY.toString()
			}
		}
	}
}
