import QtQuick
import "../components"

Panel {
	id: root

	property date now: new Date()

	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: root.now = new Date()
	}

	Column {
		anchors.centerIn: parent
		spacing: theme.spacing.small

		Label {
			theme: root.theme
			text: Qt.formatTime(root.now, "HH:mm")
			size: theme.fontSizes.large
		}

		Label {
			theme: root.theme
			text: Qt.formatDate(root.now, "ddd dd MMM")
			textColor: theme.colors.muted
			size: theme.fontSizes.small
		}
	}
}
