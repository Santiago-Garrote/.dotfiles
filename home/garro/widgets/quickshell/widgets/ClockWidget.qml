import QtQuick
import "../components"

Panel {
	id: root

	property date now: new Date()
	readonly property string timeText: Qt.formatTime(now, "HH:mm:ss")

	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: root.now = new Date()
	}

	Row {
		anchors.centerIn: parent
		spacing: theme.spacing.small

		Repeater {
			model: root.timeText.length

			Item {
				id: cell

				required property int index
				readonly property string symbol: root.timeText.charAt(index)
				readonly property bool separator: symbol === ":"

				width: separator ? 10 : 30
				height: 64

				Rectangle {
					anchors.fill: parent
					visible: !cell.separator
					color: root.theme.colors.background
					border.color: root.theme.colors.border
					border.width: root.theme.borderWidth
					radius: root.theme.cornerRadius
					opacity: 0.92

					Rectangle {
						anchors {
							left: parent.left
							right: parent.right
							top: parent.top
							margins: root.theme.spacing.small
						}
						height: 1
						color: root.theme.colors.foreground
						opacity: 0.16
					}

					Rectangle {
						anchors {
							left: parent.left
							right: parent.right
							bottom: parent.bottom
							margins: root.theme.spacing.small
						}
						height: 1
						color: root.theme.colors.accent
						opacity: 0.22
					}
				}

				Text {
					anchors.centerIn: parent
					visible: !cell.separator
					text: cell.symbol
					color: root.theme.colors.accent
					font.family: root.theme.fonts.monospace
					font.pixelSize: root.theme.fontSizes.clockDigit
					font.letterSpacing: 0
					font.bold: true
					opacity: 0.18
					scale: 1.08
				}

				Text {
					anchors.centerIn: parent
					text: cell.symbol
					color: cell.separator ? root.theme.colors.muted : root.theme.colors.accent
					font.family: root.theme.fonts.monospace
					font.pixelSize: cell.separator ? root.theme.fontSizes.clockSeparator : root.theme.fontSizes.clockDigit
					font.letterSpacing: 0
					font.bold: !cell.separator
					opacity: cell.separator ? 0.82 : 0.94
				}
			}
		}
	}
}
