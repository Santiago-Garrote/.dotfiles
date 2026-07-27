import QtQuick
import "../components"

Item {
	id: root

	required property QtObject theme

	property int gridSize: 10
	property real pointerX: 0
	property real pointerY: 0
	property bool tracking: false

	readonly property int columnIndex: tracking ? Math.max(1, Math.min(gridSize, Math.floor(pointerX / grid.width * gridSize) + 1)) : 0
	readonly property int rowIndex: tracking ? Math.max(1, Math.min(gridSize, Math.floor(pointerY / grid.height * gridSize) + 1)) : 0
	readonly property real cellWidth: grid.width / gridSize
	readonly property real cellHeight: grid.height / gridSize

	function updatePointer(mouse) {
		pointerX = Math.max(0, Math.min(grid.width - 1, mouse.x));
		pointerY = Math.max(0, Math.min(grid.height - 1, mouse.y));
		tracking = true;
	}

	Row {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.medium

		Item {
			id: grid

			width: 110
			height: width
			anchors.verticalCenter: parent.verticalCenter

			Rectangle {
				anchors.fill: parent
				color: "transparent"
				border.color: root.theme.colors.accent
				border.width: root.theme.borderWidth
			}

			Rectangle {
				visible: root.tracking
				x: (root.columnIndex - 1) * root.cellWidth
				y: 0
				width: root.cellWidth
				height: grid.height
				color: root.theme.colors.accent
				opacity: 0.16
			}

			Rectangle {
				visible: root.tracking
				x: 0
				y: (root.rowIndex - 1) * root.cellHeight
				width: grid.width
				height: root.cellHeight
				color: root.theme.colors.accent
				opacity: 0.16
			}

			Repeater {
				model: root.gridSize - 1

				Rectangle {
					x: (index + 1) * root.cellWidth
					y: 0
					width: root.theme.borderWidth
					height: grid.height
					color: root.theme.colors.accent
					opacity: 0.28
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
					opacity: 0.28
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

			MouseArea {
				anchors.fill: parent
				hoverEnabled: true
				onEntered: root.tracking = true
				onExited: root.tracking = false
				onPositionChanged: function(mouse) {
					root.updatePointer(mouse);
				}
			}
		}

		Column {
			width: parent.width - grid.width - parent.spacing
			anchors.verticalCenter: parent.verticalCenter
			spacing: root.theme.spacing.small

			ReadoutTitle {
				theme: root.theme
				title: "POINTER GRID"
			}

			Row {
				anchors.horizontalCenter: parent.horizontalCenter
				height: 46
				spacing: root.theme.spacing.medium

				SegmentBar {
					theme: root.theme
					filledSegments: root.tracking ? root.columnIndex : 0
				}

				MetricReadout {
					theme: root.theme
					value: root.tracking ? root.columnIndex.toString() : "--"
					unit: "COL"
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
					name: "ROW"
					value: root.tracking ? root.rowIndex.toString() : "--"
				}

				StatusLine {
					theme: root.theme
					name: "GRID"
					value: root.gridSize + "X" + root.gridSize
				}
			}
		}
	}
}
