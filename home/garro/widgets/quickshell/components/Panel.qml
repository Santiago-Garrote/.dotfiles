import QtQuick

Rectangle {
	id: root

	required property QtObject theme
	default property alias content: content.data

	property int padding: theme.spacing.medium

	color: theme.colors.surface
	border.color: theme.colors.border
	border.width: theme.borderWidth
	radius: theme.cornerRadius

	Item {
		id: content

		anchors.fill: parent
		anchors.margins: root.padding
	}
}
