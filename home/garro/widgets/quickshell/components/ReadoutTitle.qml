import QtQuick

Label {
	property string title: ""
	property int titleSize: theme.fontSizes.large

	anchors.horizontalCenter: parent.horizontalCenter
	text: title
	textColor: theme.colors.accent
	size: titleSize
}
