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

		ReadoutTitle {
			theme: root.theme
			title: "AUDIO OUTPUT"
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			height: 46
			spacing: root.theme.spacing.medium

			SegmentBar {
				theme: root.theme
				filledSegments: root.filledSegments
				active: !root.muted
			}

			MetricReadout {
				theme: root.theme
				value: root.volumePercent >= 0 ? root.volumePercent + "%" : "--%"
				unit: "VOL"
			}
		}

		ReadoutDivider {
			theme: root.theme
		}

		Column {
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: root.theme.spacing.small

			StatusLine {
				theme: root.theme
				name: "MODE"
				value: root.hasSink ? "ACTIVE" : "NO SINK"
			}

			StatusLine {
				theme: root.theme
				name: "MUTE"
				value: root.muted ? "ON" : "OFF"
			}
		}
	}
}
