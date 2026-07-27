import QtQuick
import "../components"

Item {
	id: root

	required property QtObject theme

	property int pointerX: 0
	property int pointerY: 0
	property bool tracking: false

	readonly property int filledSegments: tracking ? 10 : 0
	readonly property string pointerMode: tracking ? "TRACKING" : "IDLE"

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "POINTER POSITION"
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

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onEntered: root.tracking = true
		onExited: root.tracking = false
		onPositionChanged: function(mouse) {
			root.pointerX = Math.round(mouse.x);
			root.pointerY = Math.round(mouse.y);
		}
	}
}
