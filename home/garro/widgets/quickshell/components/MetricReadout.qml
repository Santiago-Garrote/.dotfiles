import QtQuick

Column {
	id: root

	required property QtObject theme

	property string value: "--"
	property string unit: ""

	anchors.verticalCenter: parent.verticalCenter
	spacing: 0

	Label {
		anchors.horizontalCenter: parent.horizontalCenter
		theme: root.theme
		text: root.value
		textColor: root.theme.colors.accent
		size: root.theme.fontSizes.large
	}

	Label {
		anchors.horizontalCenter: parent.horizontalCenter
		theme: root.theme
		text: root.unit
		textColor: root.theme.colors.accent
		size: root.theme.fontSizes.small
	}
}
