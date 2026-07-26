import QtQuick
import Quickshell.Services.Pipewire
import "../components"

Item {
	id: root

	required property QtObject theme

	readonly property var sink: Pipewire.defaultAudioSink
	readonly property bool hasSink: sink !== null && sink.audio !== null
	readonly property int volumePercent: hasSink ? Math.round(Math.max(0, Math.min(1, sink.audio.volume)) * 100) : -1
	readonly property bool muted: hasSink && sink.audio.muted
	readonly property int filledSegments: volumePercent >= 0 ? Math.ceil(volumePercent / 10) : 0

	PwObjectTracker {
		objects: root.sink !== null ? [root.sink] : []
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			theme: root.theme
			text: "AUDIO OUTPUT"
			textColor: root.theme.colors.accent
			size: root.theme.fontSizes.large
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			height: 46
			spacing: root.theme.spacing.medium

			Rectangle {
				width: 24
				height: 38
				anchors.verticalCenter: parent.verticalCenter
				color: "transparent"
				border.color: root.theme.colors.accent
				border.width: root.theme.borderWidth
				radius: root.theme.cornerRadius

				Label {
					anchors.centerIn: parent
					theme: root.theme
					text: ">"
					textColor: root.theme.colors.accent
					size: root.theme.fontSizes.medium
				}
			}

			Row {
				anchors.verticalCenter: parent.verticalCenter
				spacing: 3

				Repeater {
					model: 10

					Rectangle {
						required property int index

						width: 21
						height: 34
						color: index < root.filledSegments && !root.muted ? root.theme.colors.accent : "transparent"
						border.color: root.theme.colors.accent
						border.width: root.theme.borderWidth
						opacity: index < root.filledSegments && !root.muted ? 0.88 : 0.52
						radius: root.theme.cornerRadius
					}
				}
			}

			Column {
				anchors.verticalCenter: parent.verticalCenter
				spacing: 0

				Label {
					anchors.horizontalCenter: parent.horizontalCenter
					theme: root.theme
					text: root.volumePercent >= 0 ? root.volumePercent + "%" : "--%"
					textColor: root.theme.colors.accent
					size: root.theme.fontSizes.large
				}

				Label {
					anchors.horizontalCenter: parent.horizontalCenter
					theme: root.theme
					text: "VOL"
					textColor: root.theme.colors.accent
					size: root.theme.fontSizes.small
				}
			}
		}

		Rectangle {
			anchors.horizontalCenter: parent.horizontalCenter
			width: 300
			height: root.theme.borderWidth
			color: root.theme.colors.accent
			opacity: 0.62
		}

		Column {
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: root.theme.spacing.small

			Label {
				anchors.horizontalCenter: parent.horizontalCenter
				theme: root.theme
				text: "MODE: " + (root.hasSink ? "ACTIVE" : "NO SINK")
				textColor: root.theme.colors.accent
				size: root.theme.fontSizes.medium
			}

			Label {
				anchors.horizontalCenter: parent.horizontalCenter
				theme: root.theme
				text: "MUTE: " + (root.muted ? "ON" : "OFF")
				textColor: root.theme.colors.accent
				size: root.theme.fontSizes.medium
			}
		}
	}
}
