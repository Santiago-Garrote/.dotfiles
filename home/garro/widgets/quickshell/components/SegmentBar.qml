import QtQuick

Row {
	id: root

	required property QtObject theme

	property int filledSegments: 0
	property int segmentCount: 10
	property int segmentWidth: 21
	property int segmentHeight: 34
	property bool active: true

	anchors.verticalCenter: parent.verticalCenter
	spacing: 3

	Repeater {
		model: root.segmentCount

		Rectangle {
			required property int index

			width: root.segmentWidth
			height: root.segmentHeight
			color: root.active && index < root.filledSegments ? root.theme.colors.accent : "transparent"
			border.color: root.theme.colors.accent
			border.width: root.theme.borderWidth
			opacity: root.active && index < root.filledSegments ? 0.88 : 0.52
			radius: root.theme.cornerRadius
		}
	}
}
