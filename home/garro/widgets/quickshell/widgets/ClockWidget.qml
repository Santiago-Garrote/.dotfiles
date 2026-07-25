import QtQuick

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
