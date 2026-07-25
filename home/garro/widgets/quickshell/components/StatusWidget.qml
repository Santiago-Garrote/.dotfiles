import QtQuick

Rectangle {
	required property QtObject theme

	color: theme.colors.surface
	border.color: theme.colors.border
	border.width: theme.borderWidth
	radius: theme.cornerRadius

	Text {
		anchors.centerIn: parent
		text: "Desktop widgets"
		color: theme.colors.foreground
		font.family: theme.fonts.ui
		font.pixelSize: theme.fontSizes.medium
	}
}
