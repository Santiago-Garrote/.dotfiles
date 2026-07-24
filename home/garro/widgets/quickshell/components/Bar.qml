import QtQuick

Item {
	required property QtObject theme

	Text {
		anchors.centerIn: parent
		text: "Hello, World!"
		color: theme.colors.foreground
		font.family: theme.fonts.interface
		font.pixelSize: theme.fontSizes.medium
	}
}
