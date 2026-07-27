import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property int gridSize: 10
	property int pointerX: 0
	property int pointerY: 0
	property int monitorX: 0
	property int monitorY: 0
	property int monitorWidth: 1920
	property int monitorHeight: 1080
	property bool tracking: false

	readonly property real normalizedX: Math.max(0, Math.min(1, (pointerX - monitorX) / monitorWidth))
	readonly property real normalizedY: Math.max(0, Math.min(1, (pointerY - monitorY) / monitorHeight))
	readonly property int columnIndex: tracking ? Math.max(1, Math.min(gridSize, Math.floor(normalizedX * gridSize) + 1)) : 0
	readonly property int rowIndex: tracking ? Math.max(1, Math.min(gridSize, Math.floor(normalizedY * gridSize) + 1)) : 0
	readonly property real cellWidth: grid.width / gridSize
	readonly property real cellHeight: grid.height / gridSize
	readonly property real targetX: tracking ? normalizedX * grid.width : grid.width / 2
	readonly property real targetY: tracking ? normalizedY * grid.height : grid.height / 2

	function refreshPointer() {
		if (!pointerProcess.running)
			pointerProcess.exec(pointerProcess.command);
	}

	function refreshMonitors() {
		if (!monitorProcess.running)
			monitorProcess.exec(monitorProcess.command);
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

	function parseMonitors(output) {
		try {
			const monitors = JSON.parse(output);
			if (!Array.isArray(monitors) || monitors.length === 0)
				return;

			const selected = monitors.find(function(monitor) {
				return pointerX >= monitor.x
					&& pointerX < monitor.x + monitor.width
					&& pointerY >= monitor.y
					&& pointerY < monitor.y + monitor.height;
			}) || monitors.find(function(monitor) {
				return monitor.focused;
			}) || monitors[0];

			monitorX = selected.x || 0;
			monitorY = selected.y || 0;
			monitorWidth = selected.width || monitorWidth;
			monitorHeight = selected.height || monitorHeight;
		} catch (error) {
			return;
		}
	}

	Timer {
		interval: 100
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.refreshPointer()
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.refreshMonitors()
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

	Process {
		id: monitorProcess

		command: ["hyprctl", "-j", "monitors"]

		stdout: StdioCollector {
			id: monitorOutput
			waitForEnd: true
		}

		stderr: StdioCollector {
			waitForEnd: true
		}

		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseMonitors(monitorOutput.text);
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

		Item {
			id: grid

			width: 126
			height: width
			clip: true
			anchors.horizontalCenter: parent.horizontalCenter

			Rectangle {
				anchors.fill: parent
				color: "transparent"
				border.color: root.theme.colors.accent
				border.width: root.theme.borderWidth
				opacity: 0.86
			}

			Rectangle {
				visible: root.tracking
				x: root.targetX - width / 2
				y: 0
				width: root.theme.borderWidth
				height: grid.height
				color: root.theme.colors.accent
				opacity: 0.9
			}

			Rectangle {
				visible: root.tracking
				x: 0
				y: root.targetY - height / 2
				width: grid.width
				height: root.theme.borderWidth
				color: root.theme.colors.accent
				opacity: 0.9
			}

			Repeater {
				model: root.gridSize - 1

				Rectangle {
					x: (index + 1) * root.cellWidth
					y: 0
					width: root.theme.borderWidth
					height: grid.height
					color: root.theme.colors.accent
					opacity: 0.24
				}
			}

			Repeater {
				model: root.gridSize - 1

				Rectangle {
					x: 0
					y: (index + 1) * root.cellHeight
					width: grid.width
					height: root.theme.borderWidth
					color: root.theme.colors.accent
					opacity: 0.24
				}
			}

			Rectangle {
				visible: root.tracking
				x: (root.columnIndex - 1) * root.cellWidth
				y: (root.rowIndex - 1) * root.cellHeight
				width: root.cellWidth
				height: root.cellHeight
				color: "transparent"
				border.color: root.theme.colors.foreground
				border.width: root.theme.borderWidth
			}

			Item {
				visible: root.tracking
				x: root.targetX - width / 2
				y: root.targetY - height / 2
				width: 42
				height: 42

				Rectangle {
					x: 0
					y: 0
					width: 14
					height: root.theme.borderWidth * 2
					color: root.theme.colors.foreground
				}

				Rectangle {
					x: 0
					y: 0
					width: root.theme.borderWidth * 2
					height: 14
					color: root.theme.colors.foreground
				}

				Rectangle {
					x: parent.width - width
					y: 0
					width: 14
					height: root.theme.borderWidth * 2
					color: root.theme.colors.foreground
				}

				Rectangle {
					x: parent.width - width
					y: 0
					width: root.theme.borderWidth * 2
					height: 14
					color: root.theme.colors.foreground
				}

				Rectangle {
					x: 0
					y: parent.height - height
					width: 14
					height: root.theme.borderWidth * 2
					color: root.theme.colors.foreground
				}

				Rectangle {
					x: 0
					y: parent.height - height
					width: root.theme.borderWidth * 2
					height: 14
					color: root.theme.colors.foreground
				}

				Rectangle {
					x: parent.width - width
					y: parent.height - height
					width: 14
					height: root.theme.borderWidth * 2
					color: root.theme.colors.foreground
				}

				Rectangle {
					x: parent.width - width
					y: parent.height - height
					width: root.theme.borderWidth * 2
					height: 14
					color: root.theme.colors.foreground
				}
			}
		}

		ReadoutDivider {
			theme: root.theme
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			height: 40
			spacing: root.theme.spacing.gapInner

			MetricReadout {
				theme: root.theme
				value: root.pointerX.toString()
				unit: "X"
			}

			MetricReadout {
				theme: root.theme
				value: root.pointerY.toString()
				unit: "Y"
			}
		}
	}
}
