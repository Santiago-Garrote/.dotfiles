import QtQuick
import Quickshell.Services.Pipewire
import "../components"

Item {
	id: root

	required property QtObject theme

	readonly property var source: Pipewire.defaultAudioSource
	readonly property bool hasSource: source !== null && source.audio !== null
	readonly property int volumePercent: hasSource ? Math.round(Math.max(0, Math.min(1, source.audio.volume)) * 100) : -1
	readonly property bool muted: hasSource && source.audio.muted
	readonly property int filledSegments: volumePercent >= 0 ? Math.ceil(volumePercent / 10) : 0

	PwObjectTracker {
		objects: root.source !== null ? [root.source] : []
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "AUDIO INPUT"
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
				unit: "MIC"
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
				value: root.hasSource ? "ACTIVE" : "NO MIC"
			}

			StatusLine {
				theme: root.theme
				name: "MUTE"
				value: root.muted ? "ON" : "OFF"
			}
		}
	}
}
