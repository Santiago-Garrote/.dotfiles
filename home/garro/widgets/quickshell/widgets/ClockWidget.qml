import QtQuick
import "../components"

Item {
	id: root

	required property QtObject theme

	property date now: new Date()
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

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			theme: root.theme
			text: "SYSTEM TIME"
			textColor: root.theme.colors.accent
			size: root.theme.fontSizes.medium
		}

		Rectangle {
			anchors.horizontalCenter: parent.horizontalCenter
			width: 320
			height: root.theme.borderWidth
			color: root.theme.colors.accent
			opacity: 0.62
		}

		Item {
			anchors.horizontalCenter: parent.horizontalCenter
			width: 390
			height: 58

			Text {
				anchors.centerIn: parent
				text: root.timeText
				color: root.theme.colors.accent
				font.family: root.theme.fonts.display
				font.pixelSize: root.theme.fontSizes.clockDigit
				font.letterSpacing: 0
				opacity: 0.22
			}

			Text {
				anchors.centerIn: parent
				text: root.timeText
				color: root.theme.colors.accent
				font.family: root.theme.fonts.display
				font.pixelSize: root.theme.fontSizes.clockDigit
				font.letterSpacing: 0
				opacity: 0.96
			}
		}

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			theme: root.theme
			text: "MODE: 24H"
			textColor: root.theme.colors.accent
			size: root.theme.fontSizes.small
		}
	}
}
