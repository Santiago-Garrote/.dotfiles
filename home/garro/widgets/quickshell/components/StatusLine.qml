import QtQuick

Label {
	id: root

	property string name: ""
	property string value: ""

	anchors.horizontalCenter: parent.horizontalCenter
	text: name + ": " + value
	textColor: theme.colors.accent
	size: theme.fontSizes.medium
}
