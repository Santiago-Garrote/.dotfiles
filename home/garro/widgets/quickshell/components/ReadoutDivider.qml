import QtQuick

Rectangle {
	required property QtObject theme

	property int dividerWidth: 300

	anchors.horizontalCenter: parent.horizontalCenter
	width: dividerWidth
	height: theme.borderWidth
	color: theme.colors.accent
	opacity: 0.62
}
