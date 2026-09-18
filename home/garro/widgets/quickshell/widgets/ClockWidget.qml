import QtQuick
import "../components"

Item {
	id: root

	required property QtObject theme

	property date now: new Date()
	readonly property int hours: now.getHours()
	readonly property int minutes: now.getMinutes()
	readonly property int seconds: now.getSeconds()
	readonly property string timeText: Qt.formatTime(now, "HH:mm:ss")

	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: root.now = new Date()
	}

	Column {
		anchors {
			centerIn: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "SYSTEM TIME"
			titleSize: root.theme.fontSizes.medium
		}

		ReadoutDivider {
			theme: root.theme
			dividerWidth: 320
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: root.theme.spacing.medium

			// Hours.
			Row {
				spacing: root.theme.spacing.small

				BitColumn {
					theme: root.theme
					value: Math.floor(root.hours / 10)
				}

				BitColumn {
					theme: root.theme
					value: root.hours % 10
				}
			}

			// Minutes.
			Row {
				spacing: root.theme.spacing.small

				BitColumn {
					theme: root.theme
					value: Math.floor(root.minutes / 10)
				}

				BitColumn {
					theme: root.theme
					value: root.minutes % 10
				}
			}

			// Seconds.
			Row {
				spacing: root.theme.spacing.small

				BitColumn {
					theme: root.theme
					value: Math.floor(root.seconds / 10)
				}

				BitColumn {
					theme: root.theme
					value: root.seconds % 10
				}
			}
		}

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			theme: root.theme
			text: root.timeText
			size: root.theme.fontSizes.small
		}
	}
}
