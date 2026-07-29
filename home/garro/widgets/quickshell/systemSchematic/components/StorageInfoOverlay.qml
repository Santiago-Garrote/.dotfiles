import QtQuick
import "../../components"

Panel {
	id: root

	required property QtObject provider

	padding: root.theme.spacing.medium
	opacity: visible ? 1 : 0

	Behavior on opacity {
		NumberAnimation {
			duration: root.theme.motion.enabled ? 140 : 0
		}
	}

	Column {
		anchors.fill: parent
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "STORAGE MODULE"
		}

		Column {
			spacing: root.theme.spacing.small
			width: parent.width

			Repeater {
				model: [
					["DEVICE", root.provider.model],
					["PATH", root.provider.devicePath],
					["FILESYSTEM", root.provider.filesystemType],
					["CAPACITY", root.provider.totalCapacity],
					["USED", root.provider.usedCapacity + " (" + root.provider.usagePercentage + ")"],
					["AVAILABLE", root.provider.availableCapacity],
					["TEMPERATURE", root.provider.temperature],
					["HEALTH", root.provider.health],
					["READ", root.provider.readActivity],
					["WRITE", root.provider.writeActivity]
				]

				delegate: Row {
					required property var modelData

					width: parent.width
					height: Math.max(labelText.implicitHeight, valueText.implicitHeight)
					spacing: root.theme.spacing.medium

					Label {
						id: labelText

						theme: root.theme
						text: modelData[0]
						textColor: root.theme.colors.muted
						size: root.theme.fontSizes.small
						width: 92
						elide: Text.ElideRight
					}

					Label {
						id: valueText

						theme: root.theme
						text: modelData[1]
						textColor: root.theme.colors.foreground
						size: root.theme.fontSizes.small
						width: parent.width - labelText.width - parent.spacing
						wrapMode: Text.WrapAnywhere
						elide: Text.ElideRight
						maximumLineCount: 2
					}
				}
			}
		}
	}
}
