import QtQuick

Text {
	required property QtObject theme

	property color textColor: theme.colors.foreground
	property int size: theme.fontSizes.medium

	color: textColor
	font.family: theme.fonts.ui
	font.pixelSize: size
	font.letterSpacing: 0
}
