import QtQuick
import "../components"

Item {
	id: root

	required property QtObject theme

	property date now: new Date()
	readonly property int hours: now.getHours()
	readonly property int minutes: now.getMinutes()
	readonly property int seconds: now.getSeconds()

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
			spacing: root.theme.spacing.medium * 3

			// Hours: tens digit never exceeds 2, so it only needs 2 bits.
			Row {
				spacing: root.theme.spacing.small

				BitColumn {
					anchors.bottom: parent.bottom
					theme: root.theme
					value: Math.floor(root.hours / 10)
					bitCount: 2
				}

				BitColumn {
					anchors.bottom: parent.bottom
					theme: root.theme
					value: root.hours % 10
				}
			}

			// Minutes: tens digit never exceeds 5, so it only needs 3 bits.
			Row {
				spacing: root.theme.spacing.small

				BitColumn {
					anchors.bottom: parent.bottom
					theme: root.theme
					value: Math.floor(root.minutes / 10)
					bitCount: 3
				}

				BitColumn {
					anchors.bottom: parent.bottom
					theme: root.theme
					value: root.minutes % 10
				}
			}

			// Seconds: same range as minutes.
			Row {
				spacing: root.theme.spacing.small

				BitColumn {
					anchors.bottom: parent.bottom
					theme: root.theme
					value: Math.floor(root.seconds / 10)
					bitCount: 3
				}

				BitColumn {
					anchors.bottom: parent.bottom
					theme: root.theme
					value: root.seconds % 10
				}
			}
		}
	}
}
